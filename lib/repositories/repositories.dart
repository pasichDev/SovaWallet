import 'package:noso_rest_api/api_service.dart';
import 'package:sovawallet/repositories/noso_network_repository.dart';
import 'package:sovawallet/repositories/shared_repository.dart';

import 'file_repository.dart';
import 'local_repository.dart';

class Repositories {
  final LocalRepository localRepository;
  final NosoNetworkRepository networkRepository;
  final SharedRepository sharedRepository;
  final FileRepository fileRepository;
  final NosoApiService nosoApiService;

  Repositories({
    required this.localRepository,
    required this.networkRepository,
    required this.sharedRepository,
    required this.fileRepository,
    required this.nosoApiService,
  });
}
