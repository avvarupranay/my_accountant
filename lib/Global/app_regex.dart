class ValidateHelper {
  static const regexEmailValidation = r"^(?!\.)(?!.*\.$)(?!.*?\.\.)[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$";
  static const alphanumericWithSpaceAndComma = "[a-zA-Z0-9, ]";
  static const alphanumericWithSpace= "[a-zA-Z0-9 ]";
  static const alphanumericWithSpaceAndCommaWithHiphen = "[a-zA-Z0-9,\\-\\ ]";
  static const exceptAlphanumericWithSpaceAndComma = "[^a-zA-Z0-9, ]";
  static const exceptAlphanumeric = "[^a-zA-Z0-9]";
  static const spaceComma = "[\\s,]";
  static const alphanumericWithEmailAcceptance = "[a-zA-Z0-9@._, ]";
}