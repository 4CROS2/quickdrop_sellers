import 'package:equatable/equatable.dart';
import 'package:quickdrop_sellers/src/presentation/app_navigation_bar/presentation/widgets/destinations.dart';

class DestinationRoute extends Equatable {
  const DestinationRoute({
    required this.page,
    required this.path,
    required this.destinaton,
  });
  final int page;
  final String path;
  final Destination destinaton;

  @override
  List<Object?> get props => <Object?>[page, path, destinaton];
}
