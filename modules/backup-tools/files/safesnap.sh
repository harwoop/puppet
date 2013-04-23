#!/bin/bash

# Set your key pair here, use an account with just snapshot permissions if possible
KEY="AKIAJSJXLOSP2VLGSLQA"
SECRET="WFThqJtd6Mg0A/hxth4Q8k5Fgv4A68xd0sJb/C2M"
REGION="eu-west-1"
DATEFORMAT="%Y-%m-%d_%H:%M:%S"
EC2HOME="/opt/aws/bin"
VERSION="0.1"

if [ -z "$1" ] || [ -z "$2" ]; then
  cat <<EOT
safesnap
- Take an ec2 snapshot of a volume, freezing the filesytem first if possible

Usage:
safesnap [DEVICE] [BACKUP NAME]

e.g.
safesnap /dev/xvdf "daily"
- produces a snapshot with a description like "daily-2013-01-01 12:00:00"
- specify the actual block device "/dev/xvdf" not the one used in the EC2 tool output "/dev/sdf"
EOT
exit 0;
fi

DEVICE=$1
BNAME=$2
EC2DEVICE=$(echo "$DEVICE"|sed 's/xv/s/')

echo "safesnap version $VERSION"
echo "Getting EC2 ids..."
INSTANCE=`curl -s http://169.254.169.254/latest/meta-data/instance-id/`
echo "Our instance_id is $INSTANCE"

while IFS= read -r line; do
  if echo $line | grep -q '^BLOCK'; then
    if [ "$(echo $line|awk '{print $2}')" == "$EC2DEVICE" ]; then
      VOLUME=$(echo $line|awk '{print $3}')
      echo "Our volume_id is $VOLUME, looking for $DEVICE"
      MOUT=$(mount|grep $DEVICE)
      MOUNTPOINT=$(echo $MOUT|awk '{print $3}')
      FS=$(echo $MOUT|awk '{print $5}')
      echo "Our mountpoint is $MOUNTPOINT and our filesystem is $FS"

      if [ "$MOUNTPOINT" == "/" ]; then
        echo "Device mounted on /, not attempting to freeze filesytem"
      else
        echo "Freezing $FS filesysten"
        if [ "$FS" == "xfs" ]; then
          /usr/sbin/xfs_freeze -f $MOUNTPOINT
          if [ $? != 0 ]; then
            exit $?
          fi
        else
          /sbin/fsfreeze -f $MOUNTPOINT
        fi
      fi

      SNAPNAME="$BNAME-$(date +$DATEFORMAT)"
      echo "Creating snapshot of $VOLUME named $SNAPNAME"

      $EC2HOME/ec2-create-snapshot --aws-access-key ${KEY} --aws-secret-key ${SECRET} --region ${REGION} $VOLUME -d "$SNAPNAME"

      if [ "$MOUNTPOINT" == "/" ]; then
        # Do nothing
        true
      else
        echo "Unfreezing $FS filesysten"
        if [ "$FS" == "xfs" ]; then
          /usr/sbin/xfs_freeze -u $MOUNTPOINT
        else
          /sbin/fsfreeze -u $MOUNTPOINT
        fi
      fi

      # We are done
      exit
    fi
  fi
done < <($EC2HOME/ec2din --aws-access-key ${KEY} --aws-secret-key ${SECRET} --region ${REGION} ${INSTANCE})

