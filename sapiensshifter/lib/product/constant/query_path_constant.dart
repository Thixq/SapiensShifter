class QueryPathConstant {
  static const usersColPath = '/users';
  static const usersPreviewColPath = '/usersPreview';
  static const tableColPath = '/tables';
  static String tableOpenTableColPath(String branch) =>
      '$tableColPath/$branch/open';
  static String shiftsColPath(String userId) => '$usersColPath/$userId/shifts';
  static const categoryColPath = '/categories';
  static const extras = '/extras';
  static const productsColPath = '/products';
  static const branchColPath = '/branches';
  static const chatPreviewColPath = '/chats';
  static String messagesColPath(String chatId) =>
      '$chatPreviewColPath/$chatId/messages';
}
