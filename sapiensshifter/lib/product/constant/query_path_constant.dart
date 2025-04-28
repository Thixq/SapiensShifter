class QueryPathConstant {
  static const usersColPath = '/users';
  static const tableColPath = '/tables';
  static String tableOpenTableColPath(String branch) => 'tables/$branch/open';
  static String shiftsColPath(String userId) => 'users/$userId/shifts';
  static const categoryColPath = '/categories';
  static const extras = '/extras';
  static const productsColPath = '/products';
  static const branchColPath = '/branches';
  // CHAT
  static const chatRoomColPath = '/chats';
  static const chatPreviewColPath = '/chatPreviews';
}
