import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/movie.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieGrid({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(
        child: Text('No movies found for this genre'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie);
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: movie.mediumCoverImage,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.title,
          style: Theme.of(context).textTheme.titleSmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 16,
              color: Colors.amber[600],
            ),
            const SizedBox(width: 4),
            Text(
              movie.rating,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            Text(
              movie.year.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 2,
          children: movie.genres.take(2).map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                genre,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
