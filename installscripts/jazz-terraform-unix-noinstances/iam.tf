resource "aws_iam_role_policy_attachment" "lambdafullaccess" {
<<<<<<< HEAD
  role       = "${aws_iam_role.lambda_role.name}"
=======
  role       = "${aws_iam_role.platform_role.name}"
>>>>>>> upstream/master
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}

resource "aws_iam_role_policy_attachment" "apigatewayinvokefullAccess" {
<<<<<<< HEAD
  role       = "${aws_iam_role.lambda_role.name}"
=======
  role       = "${aws_iam_role.platform_role.name}"
>>>>>>> upstream/master
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
}

resource "aws_iam_role_policy_attachment" "cloudwatchlogaccess" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

<<<<<<< HEAD
resource "aws_iam_role_policy_attachment" "kinesisaccess" {
  role       = "${aws_iam_role.lambda_role.name}"
=======
resource "aws_iam_role_policy_attachment" "cloudwatchlogaccessbasic" {
  role       = "${aws_iam_role.platform_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "kinesisaccess" {
  role       = "${aws_iam_role.platform_role.name}"
>>>>>>> upstream/master
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}

resource "aws_iam_role_policy_attachment" "s3fullaccess" {
<<<<<<< HEAD
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "cognitopoweruser" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.envPrefix}_basic_execution"
=======
  role       = "${aws_iam_role.platform_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "sqsfullaccess" {
  role       = "${aws_iam_role.platform_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "cognitopoweruser" {
  role       = "${aws_iam_role.platform_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
}

resource "aws_iam_role_policy_attachment" "pushtocloudwatchlogs" {
  role       = "${aws_iam_role.platform_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.envPrefix}_basic_execution"
  tags = "${merge(var.additional_tags, local.common_tags)}"
>>>>>>> upstream/master
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
            "Service": "apigateway.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    },
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
<<<<<<< HEAD
=======
    },
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "logs.${var.region}.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "platform_service_policy" {
  name = "${var.envPrefix}_platform_service_policy"
  role = "${aws_iam_role.platform_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "platform_role" {
  name = "${var.envPrefix}_platform_services"
  tags = "${merge(var.additional_tags, local.common_tags)}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
            "Service": "apigateway.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    },
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    },
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "logs.${var.region}.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
>>>>>>> upstream/master
    }
  ]
}
EOF
}
