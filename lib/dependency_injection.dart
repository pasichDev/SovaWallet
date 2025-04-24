import 'package:get_it/get_it.dart';
import 'package:noso_rest_api/api_service.dart';
import 'package:sovawallet/blocs/app_data_bloc.dart';
import 'package:sovawallet/blocs/coininfo_bloc.dart';
import 'package:sovawallet/blocs/contacts_bloc.dart';
import 'package:sovawallet/blocs/debug_bloc.dart';
import 'package:sovawallet/blocs/history_transactions_bloc.dart';
import 'package:sovawallet/blocs/wallet_bloc.dart';
import 'package:sovawallet/database/database.dart';
import 'package:sovawallet/repositories/file_repository.dart';
import 'package:sovawallet/repositories/local_repository.dart';
import 'package:sovawallet/repositories/noso_network_repository.dart';
import 'package:sovawallet/repositories/repositories.dart';
import 'package:sovawallet/repositories/shared_repository.dart';
import 'package:sovawallet/services/file_service.dart';
import 'package:sovawallet/services/noso_network_service.dart';
import 'package:sovawallet/services/shared_service.dart';
import 'package:sovawallet/ui/notifer/address_tile_style_notifer.dart';
import 'package:sovawallet/ui/notifer/app_settings_notifer.dart';

final GetIt locator = GetIt.instance;
typedef AppPath = String;


Future<void> setupLocator(AppPath pathApp) async {
  /// shared & drift(sql)
  locator.registerLazySingleton<SharedService>(() => SharedService());
  locator.registerLazySingleton<MyDatabase>(
      () => MyDatabase(pathApp));
  locator.registerLazySingleton<AppSettings>(() => AppSettings());
  locator.registerLazySingleton<AddressStyleNotifier>(
      () => AddressStyleNotifier());
  locator.registerLazySingleton<NosoApiService>(() => NosoApiService());

  /// repo && services
  locator.registerLazySingleton<FileService>(() => FileService());
  locator.registerLazySingleton<FileRepository>(
      () => FileRepository(locator<FileService>()));
  locator.registerLazySingleton<NosoNetworkService>(() => NosoNetworkService());
  locator.registerLazySingleton<NosoNetworkRepository>(
      () => NosoNetworkRepository(locator<NosoNetworkService>()));
  locator.registerLazySingleton<LocalRepository>(
      () => LocalRepository(locator<MyDatabase>()));
  locator.registerLazySingleton<SharedRepository>(
      () => SharedRepository(locator<SharedService>()));
  locator.registerLazySingleton(() => Repositories(
      localRepository: locator<LocalRepository>(),
      networkRepository: locator<NosoNetworkRepository>(),
      sharedRepository: locator<SharedRepository>(),
      fileRepository: locator<FileRepository>(),
      nosoApiService: locator<NosoApiService>()));

  /// Blocs
  locator.registerLazySingleton<DebugBloc>(() => DebugBloc());
  locator.registerLazySingleton<CoinInfoBloc>(() => CoinInfoBloc(
      repositories: locator<Repositories>(), debugBloc: locator<DebugBloc>()));
  locator.registerLazySingleton<AppDataBloc>(() => AppDataBloc(
      coinInfoBloc: locator<CoinInfoBloc>(),
      repositories: locator<Repositories>(),
      debugBloc: locator<DebugBloc>()));
  locator.registerLazySingleton<WalletBloc>(() => WalletBloc(
      repositories: locator<Repositories>(),
      debugBloc: locator<DebugBloc>(),
      coinInfoBloc: locator<CoinInfoBloc>(),
      appDataBloc: locator<AppDataBloc>()));
  locator.registerLazySingleton<ContactsBloc>(
      () => ContactsBloc(repositories: locator<Repositories>()));
  locator.registerSingleton<HistoryTransactionsBloc>(
    HistoryTransactionsBloc(
      repositories: locator<Repositories>(),
      walletBloc: locator<WalletBloc>(),
    ),
  );
}
