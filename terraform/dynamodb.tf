resource "aws_dynamodb_table" "tasks-dev" {
  name = "TaskList-dev_Tasks"
  read_capacity = 1
  write_capacity = 1
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "tasks-test" {
  name = "TaskList-test_Tasks"
  read_capacity = 1
  write_capacity = 1
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
