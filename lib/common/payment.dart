import 'dart:convert';
import 'package:http/http.dart' as http;

class PayGateGlobalService {
  static const String apiKey =
      'YOUR_API_KEY'; // Replace with your actual API key

  static Future<Map<String, dynamic>> initiatePayment({
    required String phoneNumber,
    required double amount,
    required String description,
    required String identifier,
    required String network,
  }) async {
    final String apiUrl = 'https://paygateglobal.com/api/v1/pay';

    final Map<String, dynamic> requestData = {
      'auth_token': apiKey,
      'phone_number': phoneNumber,
      'amount': amount,
      'description': description,
      'identifier': identifier,
      'network': network,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    return jsonDecode(response.body);
  }

  // Add methods for other payment-related operations (e.g., check payment status)
}

// Example usage in your Flutter app:

void main() async {
  // Replace these values with actual data
  final Map<String, dynamic> paymentData =
      await PayGateGlobalService.initiatePayment(
    phoneNumber: '123456789',
    amount: 100.0,
    description: 'Test Payment',
    identifier: '123456',
    network: 'FLOOZ',
  );

  print(paymentData);

  // Handle the payment response as needed
}
