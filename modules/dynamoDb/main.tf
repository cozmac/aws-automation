resource "aws_dynamodb_table" "DynamoDB-CC" {
  name           = "${lookup(var.dynamodbparams, "name")}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "${lookup(var.dynamodbparams, "columnOne")}"
  range_key      = "${lookup(var.dynamodbparams, "columnTwo")}"

  attribute {
    name = "${lookup(var.dynamodbparams, "columnOne")}"
    type = "S"
  }

  attribute {
    name = "${lookup(var.dynamodbparams, "columnTwo")}"
    type = "S"
  }
}
