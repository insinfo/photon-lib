#[cfg(test)]
mod test {
    use crate::channels::*;
    use crate::transform::seam_carve;
    use crate::PhotonImage;

    #[test]
    fn test_alter_red_channel() {
        let width = 4;
        let height = 4;
        // Create an image from a vec of pixels
        let raw_pix = vec![
            134, 122, 131, 255, 131, 131, 139, 255, 135, 134, 137, 255, 138, 134, 130,
            255, 126, 125, 119, 255, 131, 134, 129, 255, 137, 134, 132, 255, 130, 126,
            130, 255, 132, 125, 132, 255, 122, 142, 129, 255, 134, 135, 128, 255, 138,
            120, 125, 255, 125, 134, 110, 255, 121, 122, 137, 255, 141, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let altered_r_channel_pix = vec![
            174, 122, 131, 255, 171, 131, 139, 255, 175, 134, 137, 255, 178, 134, 130,
            255, 166, 125, 119, 255, 171, 134, 129, 255, 177, 134, 132, 255, 170, 126,
            130, 255, 172, 125, 132, 255, 162, 142, 129, 255, 174, 135, 128, 255, 178,
            120, 125, 255, 165, 134, 110, 255, 161, 122, 137, 255, 181, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let mut photon_image = PhotonImage::new(raw_pix, width, height);
        alter_red_channel(&mut photon_image, 40);
        assert_eq!(photon_image.raw_pixels, altered_r_channel_pix);
    }

    #[test]
    fn test_alter_blue_channel() {
        let width = 4;
        let height = 4;
        // Create an image from a vec of pixels
        let raw_pix = vec![
            134, 122, 131, 255, 131, 131, 139, 255, 135, 134, 137, 255, 138, 134, 130,
            255, 126, 125, 119, 255, 131, 134, 129, 255, 137, 134, 132, 255, 130, 126,
            130, 255, 132, 125, 132, 255, 122, 142, 129, 255, 134, 135, 128, 255, 138,
            120, 125, 255, 125, 134, 110, 255, 121, 122, 137, 255, 141, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let altered_b_channel_pix = vec![
            134, 122, 171, 255, 131, 131, 179, 255, 135, 134, 177, 255, 138, 134, 170,
            255, 126, 125, 159, 255, 131, 134, 169, 255, 137, 134, 172, 255, 130, 126,
            170, 255, 132, 125, 172, 255, 122, 142, 169, 255, 134, 135, 168, 255, 138,
            120, 165, 255, 125, 134, 150, 255, 121, 122, 177, 255, 141, 140, 181, 255,
            125, 144, 120, 255,
        ];

        let mut photon_image = PhotonImage::new(raw_pix, width, height);
        alter_blue_channel(&mut photon_image, 40);
        assert_eq!(photon_image.raw_pixels, altered_b_channel_pix);
    }

    #[test]
    fn test_alter_green_channel() {
        let width = 4;
        let height = 4;
        // Create an image from a vec of pixels
        let raw_pix = vec![
            134, 122, 131, 255, 131, 131, 139, 255, 135, 134, 137, 255, 138, 134, 130,
            255, 126, 125, 119, 255, 131, 134, 129, 255, 137, 134, 132, 255, 130, 126,
            130, 255, 132, 125, 132, 255, 122, 142, 129, 255, 134, 135, 128, 255, 138,
            120, 125, 255, 125, 134, 110, 255, 121, 122, 137, 255, 141, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let altered_g_channel_pix = vec![
            134, 162, 131, 255, 131, 171, 139, 255, 135, 174, 137, 255, 138, 174, 130,
            255, 126, 165, 119, 255, 131, 174, 129, 255, 137, 174, 132, 255, 130, 166,
            130, 255, 132, 165, 132, 255, 122, 182, 129, 255, 134, 175, 128, 255, 138,
            160, 125, 255, 125, 174, 110, 255, 121, 162, 137, 255, 141, 180, 141, 255,
            125, 144, 120, 255,
        ];

        let mut photon_image = PhotonImage::new(raw_pix, width, height);
        alter_green_channel(&mut photon_image, 40);
        assert_eq!(photon_image.raw_pixels, altered_g_channel_pix);
    }

    #[test]
    fn test_swap_blue_green_channels() {
        let width = 4;
        let height = 4;
        // Create an image from a vec of pixels
        let raw_pix = vec![
            134, 122, 131, 255, 131, 131, 139, 255, 135, 134, 137, 255, 138, 134, 130,
            255, 126, 125, 119, 255, 131, 134, 129, 255, 137, 134, 132, 255, 130, 126,
            130, 255, 132, 125, 132, 255, 122, 142, 129, 255, 134, 135, 128, 255, 138,
            120, 125, 255, 125, 134, 110, 255, 121, 122, 137, 255, 141, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let correct_pix = vec![
            134, 131, 122, 255, 131, 139, 131, 255, 135, 137, 134, 255, 138, 130, 134,
            255, 126, 119, 125, 255, 131, 129, 134, 255, 137, 132, 134, 255, 130, 130,
            126, 255, 132, 132, 125, 255, 122, 129, 142, 255, 134, 128, 135, 255, 138,
            125, 120, 255, 125, 110, 134, 255, 121, 137, 122, 255, 141, 141, 140, 255,
            125, 144, 120, 255,
        ];

        let mut photon_image = PhotonImage::new(raw_pix, width, height);
        swap_channels(&mut photon_image, 1, 2);
        assert_eq!(photon_image.raw_pixels, correct_pix);
    }

    #[test]
    fn test_swap_blue_red_channels() {
        let width = 4;
        let height = 4;
        // Create an image from a vec of pixels
        let raw_pix = vec![
            134, 122, 131, 255, 131, 131, 139, 255, 135, 134, 137, 255, 138, 134, 130,
            255, 126, 125, 119, 255, 131, 134, 129, 255, 137, 134, 132, 255, 130, 126,
            130, 255, 132, 125, 132, 255, 122, 142, 129, 255, 134, 135, 128, 255, 138,
            120, 125, 255, 125, 134, 110, 255, 121, 122, 137, 255, 141, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let correct_pix = vec![
            131, 122, 134, 255, 139, 131, 131, 255, 137, 134, 135, 255, 130, 134, 138,
            255, 119, 125, 126, 255, 129, 134, 131, 255, 132, 134, 137, 255, 130, 126,
            130, 255, 132, 125, 132, 255, 129, 142, 122, 255, 128, 135, 134, 255, 125,
            120, 138, 255, 110, 134, 125, 255, 137, 122, 121, 255, 141, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let mut photon_image = PhotonImage::new(raw_pix, width, height);
        swap_channels(&mut photon_image, 0, 2);
        assert_eq!(photon_image.raw_pixels, correct_pix);
    }

    #[test]
    fn test_swap_green_red_channels() {
        let width = 4;
        let height = 4;
        // Create an image from a vec of pixels
        let raw_pix = vec![
            134, 122, 131, 255, 131, 131, 139, 255, 135, 134, 137, 255, 138, 134, 130,
            255, 126, 125, 119, 255, 131, 134, 129, 255, 137, 134, 132, 255, 130, 126,
            130, 255, 132, 125, 132, 255, 122, 142, 129, 255, 134, 135, 128, 255, 138,
            120, 125, 255, 125, 134, 110, 255, 121, 122, 137, 255, 141, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let correct_pix = vec![
            122, 134, 131, 255, 131, 131, 139, 255, 134, 135, 137, 255, 134, 138, 130,
            255, 125, 126, 119, 255, 134, 131, 129, 255, 134, 137, 132, 255, 126, 130,
            130, 255, 125, 132, 132, 255, 142, 122, 129, 255, 135, 134, 128, 255, 120,
            138, 125, 255, 134, 125, 110, 255, 122, 121, 137, 255, 140, 141, 141, 255,
            125, 144, 120, 255,
        ];

        let mut photon_image = PhotonImage::new(raw_pix, width, height);
        swap_channels(&mut photon_image, 1, 0);
        assert_eq!(photon_image.raw_pixels, correct_pix);
    }

    #[test]
    fn test_seam_carve() {
        let width = 4_u32;
        let height = 4_u32;
        // Create an image from a vec of pixels
        let raw_pix: Vec<u8> = vec![
            134, 122, 131, 255, 131, 131, 139, 255, 135, 134, 137, 255, 138, 134, 130,
            255, 126, 125, 119, 255, 131, 134, 129, 255, 137, 134, 132, 255, 130, 126,
            130, 255, 132, 125, 132, 255, 122, 142, 129, 255, 134, 135, 128, 255, 138,
            120, 125, 255, 125, 134, 110, 255, 121, 122, 137, 255, 141, 140, 141, 255,
            125, 144, 120, 255,
        ];

        let correct_pix: Vec<u8> = vec![
            132, 125, 132, 255, 131, 134, 129, 255, 134, 135, 128, 255, 125, 134, 110,
            255, 121, 122, 137, 255, 125, 144, 120, 255,
        ];

        let photon_image: PhotonImage = PhotonImage::new(raw_pix.clone(), width, height);
        {
            // Original image
            assert_eq!(photon_image.get_width(), width);
            assert_eq!(photon_image.get_height(), height);
        }
        {
            // Un-carved image
            // Will return the same image
            let result: PhotonImage = seam_carve(&photon_image, 100_u32, 100_u32);
            assert_eq!(result.get_width(), width);
            assert_eq!(result.get_height(), height);
            assert_eq!(result.get_raw_pixels(), raw_pix);
        }
        {
            // Carved Image, from 4x4 --> 3x2
            let new_w = 3_u32;
            let new_h = 2_u32;
            let result: PhotonImage = seam_carve(&photon_image, new_w, new_h);
            assert_eq!(result.get_width(), new_w);
            assert_eq!(result.get_height(), new_h);
            assert_eq!(result.get_raw_pixels(), correct_pix);
        }
    }
}
