namespace RazManager.Repository.Stores.Utilities
{
    public interface IImageEntity
    {
        ImageSize ImageSize { get; set; }
        byte[] Image { get; set; }
    }
}