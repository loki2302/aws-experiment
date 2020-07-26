resource "aws_ecr_repository" "ecr" {
  name = var.app_env_tag
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.ecr.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1,
      selection = {
        tagStatus = "tagged",
        tagPrefixList = ["build"],
        countType = "imageCountMoreThan",
        countNumber = 3
      },
      action = {
        type = "expire"
      }
    }]
  })
}
