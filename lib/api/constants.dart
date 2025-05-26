
const Map<String, String> jsonContentHeader = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};
const String _baseHost = 'ec2-15-223-4-120.ca-central-1.compute.amazonaws.com';
const int _port = 8088;
const String _basePath = '/api/v1';
const String _scheme = 'http';
const String baseUrl = '$_scheme://$_baseHost:$_port$_basePath';

Uri buildApiUri({
  required String endpoint,
  Map<String, dynamic>? queryParameters,
}) {
  // Normalize endpoint (ensure it starts with '/')
  final normalizedEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
  // Combine base path and endpoint
  final path = '$_basePath$normalizedEndpoint';
  return Uri(
    scheme: _scheme,
    host: _baseHost,
    port: _port,
    path: path,
    queryParameters: queryParameters?.isEmpty ?? true ? null : queryParameters,
  );
}