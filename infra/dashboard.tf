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
        "title": "Bilder behandlet"
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          ["AWS/ECS", "CPUUtilization", "ClusterName", "default", "ServiceName", "wishifai-${var.candidate_number}"],
          ["AWS/ECS", "MemoryUtilization", "ClusterName", "default", "ServiceName", "wishifai-${var.candidate_number}"]
        ],
        "period": 300,
        "stat": "Average",
        "region": "${var.aws_region}",
        "title": "ECS: CPU og minne"
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 6,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          ["AWS/ECS", "LiveTaskCount", "ClusterName", "default", "ServiceName", "wishifai-${var.candidate_number}"]
        ],
        "period": 300,
        "stat": "Average",
        "region": "${var.aws_region}",
        "title": "ECS: live tasks"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          ["wishifai-${var.candidate_number}", "bedrock.time.avg"],
          ["wishifai-${var.candidate_number}", "rekognition.time.avg"]
        ],
        "annotations": {
        "horizontal": [
         { "label": "20 sekunders alarmterskel", "value": 20000 }
         ]
         },
        "period": 300,
        "stat": "Average",
        "region": "${var.aws_region}",
        "title": "Bedrock vs. Rekognition"
       }
      },
      {
      "type": "metric",
      "x": 0,
      "y": 12,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          ["wishifai-${var.candidate_number}", "jvm.gc.overhead.value"]
        ],
        "period": 300,
        "stat": "Average",
        "region": "${var.aws_region}",
        "title": "JVM: GC-tid"
      }
    },
    {
      "type": "metric",
      "x": 12,
      "y": 12,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          ["wishifai-${var.candidate_number}", "jvm.memory.used.value", "area", "heap", "id", "G1 Eden Space", { "id": "m1", "visible": false }],
          ["wishifai-${var.candidate_number}", "jvm.memory.used.value", "area", "heap", "id", "G1 Survivor Space", { "id": "m2", "visible": false }],
          ["wishifai-${var.candidate_number}", "jvm.memory.used.value", "area", "heap", "id", "G1 Old Gen", { "id": "m3", "visible": false }],
          [{ "expression": "SUM(METRICS())", "label": "Total heap", "id": "e1" }]
        ],
        "period": 300,
        "stat": "Average",
        "region": "${var.aws_region}",
        "title": "JVM: total heap"
      }
    }
  ]
}
EOF
}