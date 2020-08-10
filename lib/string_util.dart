mixin UserUtils {
  capitalize(String iStr) {
    if (iStr == null || iStr.isEmpty)
      return '';

    if (iStr.length == 1)
      return iStr.toUpperCase();

    return '${iStr[0].toUpperCase()}${iStr.substring(1).toLowerCase()}';
  }

}

// extension MyString on String{
//   String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
// }