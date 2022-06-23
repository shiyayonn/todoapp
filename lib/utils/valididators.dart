class Validators{

  static String? isEmpty(String? text){
      if (text == null || text.isEmpty) {
                      return 'Can\'t be empty';
                    }
      return null;
  }
}