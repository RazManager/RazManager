using AutoMapper;
using RazManager.Repository.Stores.Utilities;


namespace RazManager.Repository.Utilities
{
    public class ImageToProtoResolver : IMemberValueResolver<object, object, ImageEntityBase?, Google.Protobuf.ByteString>
    {
        public Google.Protobuf.ByteString Resolve(object source, object destination, ImageEntityBase? sourceMember, Google.Protobuf.ByteString destMember, ResolutionContext context)
        {
            var image = sourceMember?.Image;

            if (image is null)
            {
                return Google.Protobuf.ByteString.Empty;
            }

            return Google.Protobuf.ByteString.CopyFrom(image);
        }
    }
}
