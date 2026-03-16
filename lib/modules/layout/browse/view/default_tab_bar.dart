import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../model/movie.dart';
import '../service/movie_service.dart';
import 'movie_grid.dart';

class DefaultTabBar extends StatefulWidget {
  const DefaultTabBar({super.key});

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Movie> _allMovies = [];
  List<String> _genres = [];
  Map<String, List<Movie>> _moviesByGenre = {};
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadMovies() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final movieResponse = await MovieService.fetchMovies();
      final genres = MovieService.extractAllGenres(movieResponse.data.movies);
      
      // Create movies by genre map
      Map<String, List<Movie>> moviesByGenre = {};
      for (String genre in genres) {
        moviesByGenre[genre] = MovieService.filterMoviesByGenre(movieResponse.data.movies, genre);
      }

      setState(() {
        _allMovies = movieResponse.data.movies;
        _genres = genres;
        _moviesByGenre = moviesByGenre;
        _isLoading = false;
        
        // Initialize tab controller after we have the genres
        _tabController = TabController(length: _genres.length, vsync: this);
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      EasyLoading.showError('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error loading movies',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadMovies,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_genres.isEmpty) {
      return const Center(
        child: Text('No genres found'),
      );
    }

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _genres.map((genre) {
            return Tab(
              text: genre,
            );
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _genres.map((genre) {
              final movies = _moviesByGenre[genre] ?? [];
              return MovieGrid(movies: movies);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
