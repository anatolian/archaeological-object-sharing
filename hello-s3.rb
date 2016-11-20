require 'aws-sdk'

NO_SUCH_BUCKET = "The bucket '%s' does not exist!"

USAGE = <<DOC

Usage: hello-s3 bucket_name [operation] [file_name]

Where:
  bucket_name (required) is the name of the bucket

  operation   is the operation to perform on the bucket:
              create  - creates a new bucket
              upload  - uploads a file to the bucket
              list    - (default) lists up to 50 bucket items

  file_name   is the name of the file to upload,
              required when operation is 'upload'

DOC

# Set the name of the bucket on which the operations are performed
# This argument is required
bucket_name = nil

if ARGV.length > 0
  bucket_name = ARGV[0]
else
  puts USAGE
  exit 1
end

# The operation to perform on the bucket
operation = 'list' # default
operation = ARGV[1] if (ARGV.length > 1)

# The file name to use with 'upload'
file = nil
file = ARGV[2] if (ARGV.length > 2)

# Get an Amazon S3 resource
s3 = Aws::S3::Resource.new(region: 'us-west-2')

# Get the bucket by name
bucket = s3.bucket(bucket_name)

case operation
when 'create'
  # Create a bucket if it doesn't already exist
  if bucket.exists?
    puts "The bucket '%s' already exists!" % bucket_name
  else
    bucket.create
    puts "Created new S3 bucket: %s" % bucket_name
  end

when 'upload'
  if file == nil
    puts "You must enter the name of the file to upload to S3!"
    exit
  end

  if bucket.exists?
    name = File.basename file

    # Check if file is already in bucket
    if bucket.object(name).exists?
      puts "#{name} already exists in the bucket"
    else
      obj = s3.bucket(bucket_name).object(name)
      obj.upload_file(file)
      puts "Uploaded '%s' to S3!" % name
    end
  else
    NO_SUCH_BUCKET % bucket_name
  end

when 'list'
  if bucket.exists?
    # Enumerate the bucket contents and object etags
    puts "Contents of '%s':" % bucket_name
    puts '  Name => GUID'

    bucket.objects.limit(50).each do |obj|
      puts "  #{obj.key} => #{obj.etag}"
    end
  else
    NO_SUCH_BUCKET % bucket_name
  end

else
  puts "Unknown operation: '%s'!" % operation
  puts USAGE
end