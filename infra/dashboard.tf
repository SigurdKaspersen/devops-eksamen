resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "wishifai-${var.candidate_number}"
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "wishifai-${var.candidate_number}",
            "images.processed.count"
          ]
        ],
        "period": 300,
        "stat": "Sum",
        "region": "${var.aws_region}",
        "title": "Images processed"
      }
    }
  ]
}
EOF
}