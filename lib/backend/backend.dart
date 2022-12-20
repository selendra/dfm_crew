/// Http Header
Map<String, String> conceteHeader({String? key, String? value}) { /* Concete More Content Of Header */
  return key != null 
  ? { /* if Parameter != Null = Concete Header With  */
    "Content-Type": "application/json; charset=utf-8", 
    'accept': 'application/json',
    key: value!
  }
  : { /* if Parameter Null = Don't integrate */
    "Content-Type": "application/json; charset=utf-8",
    'accept': 'application/json'
  };
}