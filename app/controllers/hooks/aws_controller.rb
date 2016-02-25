class Hooks::AwsController < ActionController::Base
  # POST /hooks/aws
  def create
    head :ok
  end
end

## example payload
# {
#     "version": "0",
#     "id": "6a7e8feb-b491-4cf7-a9f1-bf3703467718",
#     "detail-type": "EC2 Instance State-change Notification",
#     "source": "aws.ec2",
#     "account": "111122223333",
#     "time": "2015-12-22T18:43:48Z",
#     "region": "us-east-1",
#     "resources": [
#         "arn:aws:ec2:us-east-1:123456789012:instance/i-12345678"
#     ],
#     "detail": {
#         "instance-id": "i-12345678",
#         "state": "terminated"
#     }
# }
