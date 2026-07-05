import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hamro_barber_mobile/features/auth/models/customer_dto.dart';

/// Replaces `core/auth/customer.dart`, preserving the same secure-storage
/// keys/behavior so existing installs don't lose their session on upgrade.
class CustomerSessionService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> storeCustomerDetails(CustomerDto customer) async {
    await _storage.write(key: 'customerId', value: customer.id?.toString());
    await _storage.write(key: 'userId', value: customer.user?.id?.toString());
    await _storage.write(key: 'customerEmail', value: customer.user?.email);
    await _storage.write(key: 'firstName', value: customer.user?.firstName);
    await _storage.write(key: 'lastName', value: customer.user?.lastName);
    await _storage.write(key: 'phone', value: customer.user?.phone);
  }

  Future<int?> retrieveCustomerId() async {
    final customerId = await _storage.read(key: 'customerId');
    return customerId != null ? int.tryParse(customerId) : null;
  }

  Future<String?> retrieveCustomerEmail() => _storage.read(key: 'customerEmail');

  Future<String?> retrieveFirstName() => _storage.read(key: 'firstName');

  Future<String?> retrieveLastName() => _storage.read(key: 'lastName');

  Future<String?> retrieveUserId() => _storage.read(key: 'userId');

  Future<String?> retrievePhone() => _storage.read(key: 'phone');

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
