class AppSecrets {
  static String supabaseUrl = const String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://ookjrficalfzjwxhpwub.supabase.co',
  );
  
  static String supabaseAnonKey = const String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9va2pyZmljYWxmemp3eGhwd3ViIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2MjMwNjgsImV4cCI6MjA3OTE5OTA2OH0.j25FZOWYHsS2PgtWKyAmFIS1opp98TOpwOOipJ6bXDg',
  );
  
  static String geminiApiKey = const String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'AIzaSyAIK5C8oJwWuDF3I7AM8nqVUz0gUXyES4Y',
  );
  
  static String flutterwavePublicKey = const String.fromEnvironment(
    'FLUTTERWAVE_PUBLIC_KEY',
    defaultValue: '',
  );
}
