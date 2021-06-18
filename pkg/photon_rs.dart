@JS()
library photon_rs;

import "package:js/js.dart";
import "package:js/js_util.dart" show promiseToFuture;

// Module wasm_bindgen
/// tslint:disable
/// eslint-disable
/// Alter a select channel by incrementing or decrementing its value by a constant.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `channel` - The channel you wish to alter, it should be either 0, 1 or 2,
/// representing R, G, or B respectively. (O=Red, 1=Green, 2=Blue)
/// * `amount` - The amount to increment/decrement the channel's value by for that pixel.
/// A positive value will increment/decrement the channel's value, a negative value will decrement the channel's value.
/// ## Example
/// ```no_run
/// // For example, to increase the Red channel for all pixels by 10:
/// use photon_rs::channels::alter_channel;
/// use photon_rs::native::{open_image};
/// let mut img = open_image("img.jpg").expect("File should open");
/// alter_channel(&mut img, 0_usize, 10_i16);
/// ```
/// Adds a constant to a select R, G, or B channel's value.
/// ### Decrease a channel's value
/// // For example, to decrease the Green channel for all pixels by 20:
/// ```no_run
/// use photon_rs::channels::alter_channel;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// alter_channel(&mut img, 1_usize, -20_i16);
/// ```
/// **Note**: Note the use of a minus symbol when decreasing the channel.
@JS("wasm_bindgen.alter_channel")
external void alter_channel(PhotonImage img, num channel, num amt);

/// Increment or decrement every pixel's Red channel by a constant.
/// # Arguments
/// * `img` - A PhotonImage. See the PhotonImage struct for details.
/// * `amt` - The amount to increment or decrement the channel's value by for that pixel.
/// # Example
/// ```no_run
/// // For example, to increase the Red channel for all pixels by 10:
/// use photon_rs::channels::alter_red_channel;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// alter_red_channel(&mut img, 10_i16);
/// ```
@JS("wasm_bindgen.alter_red_channel")
external void alter_red_channel(PhotonImage photon_image, num amt);

/// Increment or decrement every pixel's Green channel by a constant.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `amt` - The amount to increment/decrement the channel's value by for that pixel.
/// # Example
/// ```no_run
/// // For example, to increase the Green channel for all pixels by 20:
/// use photon_rs::channels::alter_green_channel;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// alter_green_channel(&mut img, 20_i16);
/// ```
@JS("wasm_bindgen.alter_green_channel")
external void alter_green_channel(PhotonImage img, num amt);

/// Increment or decrement every pixel's Blue channel by a constant.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `amt` - The amount to increment or decrement the channel's value by for that pixel.
/// # Example
/// ```no_run
/// // For example, to increase the Blue channel for all pixels by 10:
/// use photon_rs::channels::alter_blue_channel;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// alter_blue_channel(&mut img, 10_i16);
/// ```
@JS("wasm_bindgen.alter_blue_channel")
external void alter_blue_channel(PhotonImage img, num amt);

/// Increment/decrement two channels' values simultaneously by adding an amt to each channel per pixel.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `channel1` - A usize from 0 to 2 that represents either the R, G or B channels.
/// * `amt1` - The amount to increment/decrement the channel's value by for that pixel.
/// * `channel2` -A usize from 0 to 2 that represents either the R, G or B channels.
/// * `amt2` - The amount to increment/decrement the channel's value by for that pixel.
/// # Example
/// ```no_run
/// // For example, to increase the values of the Red and Blue channels per pixel:
/// use photon_rs::channels::alter_two_channels;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// alter_two_channels(&mut img, 0_usize, 10_i16, 2_usize, 20_i16);
/// ```
@JS("wasm_bindgen.alter_two_channels")
external void alter_two_channels(
    PhotonImage img, num channel1, num amt1, num channel2, num amt2);

/// Increment all 3 channels' values by adding an amt to each channel per pixel.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `r_amt` - The amount to increment/decrement the Red channel by.
/// * `g_amt` - The amount to increment/decrement the Green channel by.
/// * `b_amt` - The amount to increment/decrement the Blue channel by.
/// # Example
/// ```no_run
/// // For example, to increase the values of the Red channel by 10, the Green channel by 20,
/// // and the Blue channel by 50:
/// use photon_rs::channels::alter_channels;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// alter_channels(&mut img, 10_i16, 20_i16, 50_i16);
/// ```
@JS("wasm_bindgen.alter_channels")
external void alter_channels(PhotonImage img, num r_amt, num g_amt, num b_amt);

/// Set a certain channel to zero, thus removing the channel's influence in the pixels' final rendered colour.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `channel` - The channel to be removed; must be a usize from 0 to 2, with 0 representing Red, 1 representing Green, and 2 representing Blue.
/// * `min_filter` - Minimum filter. Value between 0 and 255. Only remove the channel if the current pixel's channel value is less than this minimum filter. To completely
/// remove the channel, set this value to 255, to leave the channel as is, set to 0, and to set a channel to zero for a pixel whose red value is greater than 50,
/// then channel would be 0 and min_filter would be 50.
/// # Example
/// ```no_run
/// // For example, to remove the Red channel with a min_filter of 100:
/// use photon_rs::channels::remove_channel;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// remove_channel(&mut img, 0_usize, 100_u8);
/// ```
@JS("wasm_bindgen.remove_channel")
external void remove_channel(PhotonImage img, num channel, num min_filter);

/// Remove the Red channel's influence in an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `min_filter` - Only remove the channel if the current pixel's channel value is less than this minimum filter.
/// # Example
/// ```no_run
/// // For example, to remove the red channel for red channel pixel values less than 50:
/// use photon_rs::channels::remove_red_channel;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// remove_red_channel(&mut img, 50_u8);
/// ```
@JS("wasm_bindgen.remove_red_channel")
external void remove_red_channel(PhotonImage img, num min_filter);

/// Remove the Green channel's influence in an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `min_filter` - Only remove the channel if the current pixel's channel value is less than this minimum filter.
/// # Example
/// ```no_run
/// // For example, to remove the green channel for green channel pixel values less than 50:
/// use photon_rs::channels::remove_green_channel;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// remove_green_channel(&mut img, 50_u8);
/// ```
@JS("wasm_bindgen.remove_green_channel")
external void remove_green_channel(PhotonImage img, num min_filter);

/// Remove the Blue channel's influence in an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `min_filter` - Only remove the channel if the current pixel's channel value is less than this minimum filter.
/// # Example
/// ```no_run
/// // For example, to remove the blue channel for blue channel pixel values less than 50:
/// use photon_rs::channels::remove_blue_channel;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// remove_blue_channel(&mut img, 50_u8);
/// ```
@JS("wasm_bindgen.remove_blue_channel")
external void remove_blue_channel(PhotonImage img, num min_filter);

/// Swap two channels.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `channel1` - An index from 0 to 2, representing the Red, Green or Blue channels respectively. Red would be represented by 0, Green by 1, and Blue by 2.
/// * `channel2` - An index from 0 to 2, representing the Red, Green or Blue channels respectively. Same as above.
/// # Example
/// ```no_run
/// // For example, to swap the values of the Red channel with the values of the Blue channel:
/// use photon_rs::channels::swap_channels;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// swap_channels(&mut img, 0_usize, 2_usize);
/// ```
@JS("wasm_bindgen.swap_channels")
external void swap_channels(PhotonImage img, num channel1, num channel2);

/// Invert RGB value of an image.
/// # Arguments
/// * `photon_image` - A DynamicImage that contains a view into the image.
/// # Example
/// ```no_run
/// use photon_rs::channels::invert;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// invert(&mut img);
/// ```
@JS("wasm_bindgen.invert")
external void invert(PhotonImage photon_image);

/// Selective hue rotation.
/// Only rotate the hue of a pixel if its RGB values are within a specified range.
/// This function only rotates a pixel's hue to another  if it is visually similar to the colour specified.
/// For example, if a user wishes all pixels that are blue to be changed to red, they can selectively specify  only the blue pixels to be changed.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `ref_color` - The `RGB` value of the reference color (to be compared to)
/// * `degrees` - The amount of degrees to hue rotate by.
/// # Example
/// ```no_run
/// // For example, to only rotate the pixels that are of RGB value RGB{20, 40, 60}:
/// use photon_rs::Rgb;
/// use photon_rs::channels::selective_hue_rotate;
/// use photon_rs::native::open_image;
/// let ref_color = Rgb::new(20_u8, 40_u8, 60_u8);
/// let mut img = open_image("img.jpg").expect("File should open");
/// selective_hue_rotate(&mut img, ref_color, 180_f32);
/// ```
@JS("wasm_bindgen.selective_hue_rotate")
external void selective_hue_rotate(
    PhotonImage photon_image, Rgb ref_color, num degrees);

/// Selectively lighten an image.
/// Only lighten the hue of a pixel if its colour matches or is similar to the RGB colour specified.
/// For example, if a user wishes all pixels that are blue to be lightened, they can selectively specify  only the blue pixels to be changed.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `ref_color` - The `RGB` value of the reference color (to be compared to)
/// * `amt` - The level from 0 to 1 to lighten the hue by. Increasing by 10% would have an `amt` of 0.1
/// # Example
/// ```no_run
/// // For example, to only lighten the pixels that are of or similar to RGB value RGB{20, 40, 60}:
/// use photon_rs::Rgb;
/// use photon_rs::channels::selective_lighten;
/// use photon_rs::native::open_image;
/// let ref_color = Rgb::new(20_u8, 40_u8, 60_u8);
/// let mut img = open_image("img.jpg").expect("File should open");
/// selective_lighten(&mut img, ref_color, 0.2_f32);
/// ```
@JS("wasm_bindgen.selective_lighten")
external void selective_lighten(PhotonImage img, Rgb ref_color, num amt);

/// Selectively desaturate pixel colours which are similar to the reference colour provided.
/// Similarity between two colours is calculated via the CIE76 formula.
/// Only desaturates the hue of a pixel if its similarity to the reference colour is within the range in the algorithm.
/// For example, if a user wishes all pixels that are blue to be desaturated by 0.1, they can selectively specify  only the blue pixels to be changed.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `ref_color` - The `RGB` value of the reference color (to be compared to)
/// * `amt` - The amount of desaturate the colour by.
/// # Example
/// ```no_run
/// // For example, to only desaturate the pixels that are similar to the RGB value RGB{20, 40, 60}:
/// use photon_rs::Rgb;
/// use photon_rs::channels::selective_desaturate;
/// use photon_rs::native::open_image;
/// let ref_color = Rgb::new(20_u8, 40_u8, 60_u8);
/// let mut img = open_image("img.jpg").expect("File should open");
/// selective_desaturate(&mut img, ref_color, 0.1_f32);
/// ```
@JS("wasm_bindgen.selective_desaturate")
external void selective_desaturate(PhotonImage img, Rgb ref_color, num amt);

/// Selectively saturate pixel colours which are similar to the reference colour provided.
/// Similarity between two colours is calculated via the CIE76 formula.
/// Only saturates the hue of a pixel if its similarity to the reference colour is within the range in the algorithm.
/// For example, if a user wishes all pixels that are blue to have an increase in saturation by 10%, they can selectively specify only the blue pixels to be changed.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `ref_color` - The `RGB` value of the reference color (to be compared to)
/// * `amt` - The amount of saturate the colour by.
/// # Example
/// ```no_run
/// // For example, to only increase the saturation of pixels that are similar to the RGB value RGB{20, 40, 60}:
/// use photon_rs::Rgb;
/// use photon_rs::channels::selective_saturate;
/// use photon_rs::native::open_image;
/// let ref_color = Rgb::new(20_u8, 40_u8, 60_u8);
/// let mut img = open_image("img.jpg").expect("File should open");
/// selective_saturate(&mut img, ref_color, 0.1_f32);
/// ```
@JS("wasm_bindgen.selective_saturate")
external void selective_saturate(PhotonImage img, Rgb ref_color, num amt);

/// Selectively changes a pixel to greyscale if it is *not* visually similar or close to the colour specified.
/// Only changes the colour of a pixel if its RGB values are within a specified range.
/// (Similarity between two colours is calculated via the CIE76 formula.)
/// For example, if a user wishes all pixels that are *NOT* blue to be displayed in greyscale, they can selectively specify only the blue pixels to be
/// kept in the photo.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `ref_color` - The `RGB` value of the reference color (to be compared to)
/// # Example
/// ```no_run
/// // For example, to greyscale all pixels that are *not* visually similar to the RGB colour RGB{20, 40, 60}:
/// use photon_rs::Rgb;
/// use photon_rs::channels::selective_greyscale;
/// use photon_rs::native::open_image;
/// let ref_color = Rgb::new(20_u8, 40_u8, 60_u8);
/// let mut img = open_image("img.jpg").expect("File should open");
/// selective_greyscale(img, ref_color);
/// ```
@JS("wasm_bindgen.selective_greyscale")
external void selective_greyscale(PhotonImage photon_image, Rgb ref_color);

/// Solarization on the Blue channel.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::neue;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// neue(&mut img);
/// ```
@JS("wasm_bindgen.neue")
external void neue(PhotonImage photon_image);

/// Solarization on the Red and Green channels.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::lix;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// lix(&mut img);
/// ```
@JS("wasm_bindgen.lix")
external void lix(PhotonImage photon_image);

/// Solarization on the Red and Blue channels.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::ryo;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// ryo(&mut img);
/// ```
@JS("wasm_bindgen.ryo")
external void ryo(PhotonImage photon_image);

/// Apply a filter to an image. Over 20 filters are available.
/// The filters are as follows:
/// * **oceanic**: Add an aquamarine-tinted hue to an image.
/// * **islands**: Aquamarine tint.
/// * **marine**: Add a green/blue mixed hue to an image.
/// * **seagreen**: Dark green hue, with tones of blue.
/// * **flagblue**: Royal blue tint
/// * **liquid**: Blue-inspired tint.
/// * **diamante**: Custom filter with a blue/turquoise tint.
/// * **radio**: Fallout-style radio effect.
/// * **twenties**: Slight-blue tinted historical effect.
/// * **rosetint**: Rose-tinted filter.
/// * **mauve**: Purple-infused filter.
/// * **bluechrome**: Blue monochrome effect.
/// * **vintage**: Vintage filter with a red tint.
/// * **perfume**: Increase the blue channel, with moderate increases in the Red and Green channels.
/// * **serenity**: Custom filter with an increase in the Blue channel's values.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `filter_name` - The filter's name. Choose from the selection above, eg: "oceanic"
/// # Example
/// ```no_run
/// // For example, to add a filter called "vintage" to an image:
/// use photon_rs::filters::filter;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// filter(&mut img, "vintage");
/// ```
@JS("wasm_bindgen.filter")
external void filter(PhotonImage img, String filter_name);

/// Apply a lofi effect to an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::lofi;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// lofi(&mut img);
/// ```
@JS("wasm_bindgen.lofi")
external void lofi(PhotonImage img);

/// Apply a rose tint to an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::pastel_pink;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// pastel_pink(&mut img);
/// ```
@JS("wasm_bindgen.pastel_pink")
external void pastel_pink(PhotonImage img);

/// Apply a vintage, golden hue to an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::golden;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// golden(&mut img);
/// ```
@JS("wasm_bindgen.golden")
external void golden(PhotonImage img);

/// Increased contrast filter effect.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::cali;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// cali(&mut img);
/// ```
@JS("wasm_bindgen.cali")
external void cali(PhotonImage img);

/// Greyscale effect with increased contrast.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::dramatic;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// dramatic(&mut img);
/// ```
@JS("wasm_bindgen.dramatic")
external void dramatic(PhotonImage img);

/// Apply a red hue, with increased contrast and brightness.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::firenze;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// firenze(&mut img);
/// ```
@JS("wasm_bindgen.firenze")
external void firenze(PhotonImage img);

/// Apply a greyscale effect with increased contrast.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::filters::obsidian;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// obsidian(&mut img);
/// ```
@JS("wasm_bindgen.obsidian")
external void obsidian(PhotonImage img);

/// Noise reduction.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to noise reduct an image:
/// use photon_rs::conv::noise_reduction;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// noise_reduction(&mut img);
/// ```
/// Adds a constant to a select R, G, or B channel's value.
@JS("wasm_bindgen.noise_reduction")
external void noise_reduction(PhotonImage photon_image);

/// Sharpen an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to sharpen an image:
/// use photon_rs::conv::sharpen;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// sharpen(&mut img);
/// ```
/// Adds a constant to a select R, G, or B channel's value.
@JS("wasm_bindgen.sharpen")
external void sharpen(PhotonImage photon_image);

/// Apply edge detection to an image, to create a dark version with its edges highlighted.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to increase the Red channel for all pixels by 10:
/// use photon_rs::conv::edge_detection;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// edge_detection(&mut img);
/// ```
@JS("wasm_bindgen.edge_detection")
external void edge_detection(PhotonImage photon_image);

/// Apply an identity kernel convolution to an image.
/// # Arguments
/// * `img` -A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to apply an identity kernel convolution:
/// use photon_rs::conv::identity;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// identity(&mut img);
/// ```
@JS("wasm_bindgen.identity")
external void identity(PhotonImage photon_image);

/// Apply a box blur effect.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to apply a box blur effect:
/// use photon_rs::conv::box_blur;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// box_blur(&mut img);
/// ```
@JS("wasm_bindgen.box_blur")
external void box_blur(PhotonImage photon_image);

/// Gaussian blur in linear time.
/// Reference: http://blog.ivank.net/fastest-gaussian-blur.html
/// # Arguments
/// * `photon_image` - A PhotonImage
/// * `radius` - blur radius
/// # Example
/// ```no_run
/// use photon_rs::conv::gaussian_blur;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// gaussian_blur(&mut img, 3_i32);
/// ```
@JS("wasm_bindgen.gaussian_blur")
external void gaussian_blur(PhotonImage photon_image, num radius);

/// Detect horizontal lines in an image, and highlight these only.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to display the horizontal lines in an image:
/// use photon_rs::conv::detect_horizontal_lines;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// detect_horizontal_lines(&mut img);
/// ```
@JS("wasm_bindgen.detect_horizontal_lines")
external void detect_horizontal_lines(PhotonImage photon_image);

/// Detect vertical lines in an image, and highlight these only.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to display the vertical lines in an image:
/// use photon_rs::conv::detect_vertical_lines;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// detect_vertical_lines(&mut img);
/// ```
@JS("wasm_bindgen.detect_vertical_lines")
external void detect_vertical_lines(PhotonImage photon_image);

/// Detect lines at a forty five degree angle in an image, and highlight these only.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to display the lines at a forty five degree angle in an image:
/// use photon_rs::conv::detect_45_deg_lines;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// detect_45_deg_lines(&mut img);
/// ```
@JS("wasm_bindgen.detect_45_deg_lines")
external void detect_45_deg_lines(PhotonImage photon_image);

/// Detect lines at a 135 degree angle in an image, and highlight these only.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to display the lines at a 135 degree angle in an image:
/// use photon_rs::conv::detect_135_deg_lines;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// detect_135_deg_lines(&mut img);
/// ```
@JS("wasm_bindgen.detect_135_deg_lines")
external void detect_135_deg_lines(PhotonImage photon_image);

/// Apply a standard laplace convolution.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to apply a laplace effect:
/// use photon_rs::conv::laplace;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// laplace(&mut img);
/// ```
@JS("wasm_bindgen.laplace")
external void laplace(PhotonImage photon_image);

/// Preset edge effect.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to apply this effect:
/// use photon_rs::conv::edge_one;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// edge_one(&mut img);
/// ```
@JS("wasm_bindgen.edge_one")
external void edge_one(PhotonImage photon_image);

/// Apply an emboss effect to an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to apply an emboss effect:
/// use photon_rs::conv::emboss;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// emboss(&mut img);
/// ```
@JS("wasm_bindgen.emboss")
external void emboss(PhotonImage photon_image);

/// Apply a horizontal Sobel filter to an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to apply a horizontal Sobel filter:
/// use photon_rs::conv::sobel_horizontal;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// sobel_horizontal(&mut img);
/// ```
@JS("wasm_bindgen.sobel_horizontal")
external void sobel_horizontal(PhotonImage photon_image);

/// Apply a horizontal Prewitt convolution to an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to apply a horizontal Prewitt convolution effect:
/// use photon_rs::conv::prewitt_horizontal;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// prewitt_horizontal(&mut img);
/// ```
@JS("wasm_bindgen.prewitt_horizontal")
external void prewitt_horizontal(PhotonImage photon_image);

/// Apply a vertical Sobel filter to an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to apply a vertical Sobel filter:
/// use photon_rs::conv::sobel_vertical;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// sobel_vertical(&mut img);
/// ```
@JS("wasm_bindgen.sobel_vertical")
external void sobel_vertical(PhotonImage photon_image);

/// Crop an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to crop an image at (0, 0) to (500, 800)
/// use photon_rs::native::{open_image};
/// use photon_rs::transform::crop;
/// use photon_rs::PhotonImage;
/// let mut img = open_image("img.jpg").expect("File should open");
/// let cropped_img: PhotonImage = crop(&mut img, 0_u32, 0_u32, 500_u32, 800_u32);
/// // Write the contents of this image in JPG format.
/// ```
@JS("wasm_bindgen.crop")
external PhotonImage crop(
    PhotonImage photon_image, num x1, num y1, num x2, num y2);
@JS("wasm_bindgen.crop_img_browser")
external HTMLCanvasElement crop_img_browser(
    HTMLCanvasElement source_canvas, num width, num height, num left, num top);

/// Flip an image horizontally.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to flip an image horizontally:
/// use photon_rs::native::open_image;
/// use photon_rs::transform::fliph;
/// let mut img = open_image("img.jpg").expect("File should open");
/// fliph(&mut img);
/// ```
@JS("wasm_bindgen.fliph")
external void fliph(PhotonImage photon_image);

/// Flip an image vertically.
/// # Arguments
/// * `img` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to flip an image vertically:
/// use photon_rs::native::open_image;
/// use photon_rs::transform::flipv;
/// let mut img = open_image("img.jpg").expect("File should open");
/// flipv(&mut img);
/// ```
@JS("wasm_bindgen.flipv")
external void flipv(PhotonImage photon_image);

/// Resize an image on the web.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `width` - New width.
/// * `height` - New height.
/// * `sampling_filter` - Nearest = 1, Triangle = 2, CatmullRom = 3, Gaussian = 4, Lanczos3 = 5
@JS("wasm_bindgen.resize_img_browser")
external HTMLCanvasElement resize_img_browser(
    PhotonImage photon_img, num width, num height, num sampling_filter);

/// Resize an image.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `width` - New width.
/// * `height` - New height.
/// * `sampling_filter` - Nearest = 1, Triangle = 2, CatmullRom = 3, Gaussian = 4, Lanczos3 = 5
@JS("wasm_bindgen.resize")
external PhotonImage resize(
    PhotonImage photon_img, num width, num height, num sampling_filter);

/// Resize image using seam carver.
/// Resize only if new dimensions are smaller, than original image.
/// # NOTE: This is still experimental feature, and pretty slow.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `width` - New width.
/// * `height` - New height.
/// # Example
/// ```no_run
/// // For example, resize image using seam carver:
/// use photon_rs::native::open_image;
/// use photon_rs::transform::seam_carve;
/// use photon_rs::PhotonImage;
/// let img = open_image("img.jpg").expect("File should open");
/// let result: PhotonImage = seam_carve(&img, 100_u32, 100_u32);
/// ```
@JS("wasm_bindgen.seam_carve")
external PhotonImage seam_carve(PhotonImage img, num width, num height);

/// Apply uniform padding around the PhotonImage
/// A padded PhotonImage is returned.
/// # Arguments
/// * `img` - A PhotonImage. See the PhotonImage struct for details.
/// * `padding` - The amount of padding to be applied to the PhotonImage.
/// * `padding_rgba` - Tuple containing the RGBA code for padding color.
/// # Example
/// ```no_run
/// // For example, to apply a padding of 10 pixels around a PhotonImage:
/// use photon_rs::transform::padding_uniform;
/// use photon_rs::native::open_image;
/// use photon_rs::Rgba;
/// let mut img = open_image("img.jpg").expect("File should open");
/// let rgba = Rgba::new(200_u8, 100_u8, 150_u8, 255_u8);
/// padding_uniform(&img, 10_u32, rgba);
/// ```
@JS("wasm_bindgen.padding_uniform")
external PhotonImage padding_uniform(
    PhotonImage img, num padding, Rgba padding_rgba);

/// Apply padding on the left side of the PhotonImage
/// A padded PhotonImage is returned.
/// # Arguments
/// * `img` - A PhotonImage. See the PhotonImage struct for details.
/// * `padding` - The amount of padding to be applied to the PhotonImage.
/// * `padding_rgba` - Tuple containing the RGBA code for padding color.
/// # Example
/// ```no_run
/// // For example, to apply a padding of 10 pixels on the left side of a PhotonImage:
/// use photon_rs::transform::padding_left;
/// use photon_rs::native::open_image;
/// use photon_rs::Rgba;
/// let mut img = open_image("img.jpg").expect("File should open");
/// let rgba = Rgba::new(200_u8, 100_u8, 150_u8, 255_u8);
/// padding_left(&img, 10_u32, rgba);
/// ```
@JS("wasm_bindgen.padding_left")
external PhotonImage padding_left(
    PhotonImage img, num padding, Rgba padding_rgba);

/// Apply padding on the left side of the PhotonImage
/// A padded PhotonImage is returned.
/// # Arguments
/// * `img` - A PhotonImage. See the PhotonImage struct for details.
/// * `padding` - The amount of padding to be applied to the PhotonImage.
/// * `padding_rgba` - Tuple containing the RGBA code for padding color.
/// # Example
/// ```no_run
/// // For example, to apply a padding of 10 pixels on the right side of a PhotonImage:
/// use photon_rs::transform::padding_right;
/// use photon_rs::native::open_image;
/// use photon_rs::Rgba;
/// let mut img = open_image("img.jpg").expect("File should open");
/// let rgba = Rgba::new(200_u8, 100_u8, 150_u8, 255_u8);
/// padding_right(&img, 10_u32, rgba);
/// ```
@JS("wasm_bindgen.padding_right")
external PhotonImage padding_right(
    PhotonImage img, num padding, Rgba padding_rgba);

/// Apply padding on the left side of the PhotonImage
/// A padded PhotonImage is returned.
/// # Arguments
/// * `img` - A PhotonImage. See the PhotonImage struct for details.
/// * `padding` - The amount of padding to be applied to the PhotonImage.
/// * `padding_rgba` - Tuple containing the RGBA code for padding color.
/// # Example
/// ```no_run
/// // For example, to apply a padding of 10 pixels on the top of a PhotonImage:
/// use photon_rs::transform::padding_top;
/// use photon_rs::native::open_image;
/// use photon_rs::Rgba;
/// let mut img = open_image("img.jpg").expect("File should open");
/// let rgba = Rgba::new(200_u8, 100_u8, 150_u8, 255_u8);
/// padding_top(&img, 10_u32, rgba);
/// ```
@JS("wasm_bindgen.padding_top")
external PhotonImage padding_top(
    PhotonImage img, num padding, Rgba padding_rgba);

/// Apply padding on the left side of the PhotonImage
/// A padded PhotonImage is returned.
/// # Arguments
/// * `img` - A PhotonImage. See the PhotonImage struct for details.
/// * `padding` - The amount of padding to be applied to the PhotonImage.
/// * `padding_rgba` - Tuple containing the RGBA code for padding color.
/// # Example
/// ```no_run
/// // For example, to apply a padding of 10 pixels on the bottom of a PhotonImage:
/// use photon_rs::transform::padding_bottom;
/// use photon_rs::native::open_image;
/// use photon_rs::Rgba;
/// let mut img = open_image("img.jpg").expect("File should open");
/// let rgba = Rgba::new(200_u8, 100_u8, 150_u8, 255_u8);
/// padding_bottom(&img, 10_u32, rgba);
/// ```
@JS("wasm_bindgen.padding_bottom")
external PhotonImage padding_bottom(
    PhotonImage img, num padding, Rgba padding_rgba);

/// ! [temp] Check if WASM is supported.
@JS("wasm_bindgen.run")
external void run();

/// Get the ImageData from a 2D canvas context
@JS("wasm_bindgen.get_image_data")
external ImageData get_image_data(
    HTMLCanvasElement canvas, CanvasRenderingContext2D ctx);

/// Place a PhotonImage onto a 2D canvas.
@JS("wasm_bindgen.putImageData")
external void putImageData(HTMLCanvasElement canvas,
    CanvasRenderingContext2D ctx, PhotonImage new_image);

/// Convert a HTML5 Canvas Element to a PhotonImage.
/// This converts the ImageData found in the canvas context to a PhotonImage,
/// which can then have effects or filters applied to it.
@JS("wasm_bindgen.open_image")
external PhotonImage open_image(
    HTMLCanvasElement canvas, CanvasRenderingContext2D ctx);
@JS("wasm_bindgen.open_image_test")
external PhotonImage open_image_test(
    HTMLCanvasElement canvas, CanvasRenderingContext2D ctx);

/// Convert ImageData to a raw pixel vec of u8s.
@JS("wasm_bindgen.to_raw_pixels")
external Uint8Array to_raw_pixels(ImageData imgdata);

/// Convert a base64 string to a PhotonImage.
@JS("wasm_bindgen.base64_to_image")
external PhotonImage base64_to_image(String base64);

/// Convert a base64 string to a Vec of u8s.
@JS("wasm_bindgen.base64_to_vec")
external Uint8Array base64_to_vec(String base64);

/// Convert a PhotonImage to JS-compatible ImageData.
@JS("wasm_bindgen.to_image_data")
external ImageData to_image_data(PhotonImage photon_image);

/// Adds an offset to the image by a certain number of pixels.
/// This creates an RGB shift effect.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `offset` - The offset is added to the pixels in the image.
/// # Example
/// ```no_run
/// // For example, to offset pixels by 30 pixels on the red channel:
/// use photon_rs::effects::offset;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// offset(&mut img, 0_usize, 30_u32);
/// ```
@JS("wasm_bindgen.offset")
external void offset(PhotonImage photon_image, num channel_index, num offset);

/// Adds an offset to the red channel by a certain number of pixels.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `offset` - The offset you want to move the red channel by.
/// # Example
/// ```no_run
/// // For example, to add an offset to the red channel by 30 pixels.
/// use photon_rs::effects::offset_red;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// offset_red(&mut img, 30_u32);
/// ```
@JS("wasm_bindgen.offset_red")
external void offset_red(PhotonImage img, num offset_amt);

/// Adds an offset to the green channel by a certain number of pixels.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `offset` - The offset you want to move the green channel by.
/// # Example
/// ```no_run
/// // For example, to add an offset to the green channel by 30 pixels.
/// use photon_rs::effects::offset_green;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// offset_green(&mut img, 30_u32);
/// ```
@JS("wasm_bindgen.offset_green")
external void offset_green(PhotonImage img, num offset_amt);

/// Adds an offset to the blue channel by a certain number of pixels.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `offset_amt` - The offset you want to move the blue channel by.
/// # Example
/// // For example, to add an offset to the green channel by 40 pixels.
/// ```no_run
/// use photon_rs::effects::offset_blue;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// offset_blue(&mut img, 40_u32);
/// ```
@JS("wasm_bindgen.offset_blue")
external void offset_blue(PhotonImage img, num offset_amt);

/// Adds multiple offsets to the image by a certain number of pixels (on two channels).
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `offset` - The offset is added to the pixels in the image.
/// # Example
/// ```no_run
/// // For example, to add a 30-pixel offset to both the red and blue channels:
/// use photon_rs::effects::multiple_offsets;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// multiple_offsets(&mut img, 30_u32, 0_usize, 2_usize);
/// ```
@JS("wasm_bindgen.multiple_offsets")
external void multiple_offsets(PhotonImage photon_image, num offset,
    num channel_index, num channel_index2);

/// Reduces an image to the primary colours.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// # Example
/// ```no_run
/// // For example, to add a primary colour effect to an image of type `DynamicImage`:
/// use photon_rs::effects::primary;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// primary(&mut img);
/// ```
@JS("wasm_bindgen.primary")
external void primary(PhotonImage img);

/// Colorizes the green channels of the image.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// # Example
/// ```no_run
/// // For example, to colorize an image of type `PhotonImage`:
/// use photon_rs::effects::colorize;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// colorize(&mut img);
/// ```
@JS("wasm_bindgen.colorize")
external void colorize(PhotonImage photon_image);

/// Applies a solarizing effect to an image.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// # Example
/// ```no_run
/// // For example, to colorize an image of type `PhotonImage`:
/// use photon_rs::effects::solarize;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// solarize(&mut img);
/// ```
@JS("wasm_bindgen.solarize")
external void solarize(PhotonImage photon_image);

/// Applies a solarizing effect to an image and returns the resulting PhotonImage.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// # Example
/// ```no_run
/// // For example, to solarize "retimg" an image of type `PhotonImage`:
/// use photon_rs::effects::solarize_retimg;
/// use photon_rs::native::open_image;
/// use photon_rs::PhotonImage;
/// let img = open_image("img.jpg").expect("File should open");
/// let result: PhotonImage = solarize_retimg(&img);
/// ```
@JS("wasm_bindgen.solarize_retimg")
external PhotonImage solarize_retimg(PhotonImage photon_image);

/// Increase the brightness of an image by a factor.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `brightness` - A u8 to add to the brightness.
/// # Example
/// ```no_run
/// use photon_rs::effects::inc_brightness;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// inc_brightness(&mut img, 10_u8);
/// ```
@JS("wasm_bindgen.inc_brightness")
external void inc_brightness(PhotonImage photon_image, num brightness);

/// Adjust the contrast of an image by a factor.
/// # Arguments
/// * `photon_image` - A PhotonImage that contains a view into the image.
/// * `contrast` - An f32 factor used to adjust contrast. Between [-255.0, 255.0]. The algorithm will
/// clamp results if passed factor is out of range.
/// # Example
/// ```no_run
/// use photon_rs::effects::adjust_contrast;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// adjust_contrast(&mut img, 30_f32);
/// ```
@JS("wasm_bindgen.adjust_contrast")
external void adjust_contrast(PhotonImage photon_image, num contrast);

/// Tint an image by adding an offset to averaged RGB channel values.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `r_offset` - The amount the R channel should be incremented by.
/// * `g_offset` - The amount the G channel should be incremented by.
/// * `b_offset` - The amount the B channel should be incremented by.
/// # Example
/// ```no_run
/// // For example, to tint an image of type `PhotonImage`:
/// use photon_rs::effects::tint;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// tint(&mut img, 10_u32, 20_u32, 15_u32);
/// ```
@JS("wasm_bindgen.tint")
external void tint(
    PhotonImage photon_image, num r_offset, num g_offset, num b_offset);

/// Horizontal strips. Divide an image into a series of equal-height strips, for an artistic effect.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `num_strips` - The numbder of strips
/// # Example
/// ```no_run
/// // For example, to oil an image of type `PhotonImage`:
/// use photon_rs::effects::horizontal_strips;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// horizontal_strips(&mut img, 8u8);
/// ```
@JS("wasm_bindgen.horizontal_strips")
external void horizontal_strips(PhotonImage photon_image, num num_strips);

/// Horizontal strips. Divide an image into a series of equal-width strips, for an artistic effect. Sepcify a color as well.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `num_strips` - The numbder of strips
/// * `color` - Color of strips.
/// # Example
/// ```no_run
/// // For example, to oil an image of type `PhotonImage`:
/// use photon_rs::effects::color_horizontal_strips;
/// use photon_rs::native::open_image;
/// use photon_rs::Rgb;
/// let color = Rgb::new(255u8, 0u8, 0u8);
/// let mut img = open_image("img.jpg").expect("File should open");
/// color_horizontal_strips(&mut img, 8u8, color);
/// ```
@JS("wasm_bindgen.color_horizontal_strips")
external void color_horizontal_strips(
    PhotonImage photon_image, num num_strips, Rgb color);

/// Vertical strips. Divide an image into a series of equal-width strips, for an artistic effect.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `num_strips` - The numbder of strips
/// # Example
/// ```no_run
/// // For example, to oil an image of type `PhotonImage`:
/// use photon_rs::effects::vertical_strips;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// vertical_strips(&mut img, 8u8);
/// ```
@JS("wasm_bindgen.vertical_strips")
external void vertical_strips(PhotonImage photon_image, num num_strips);

/// Vertical strips. Divide an image into a series of equal-width strips, for an artistic effect. Sepcify a color as well.
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `num_strips` - The numbder of strips
/// * `color` - Color of strips.
/// # Example
/// ```no_run
/// // For example, to oil an image of type `PhotonImage`:
/// use photon_rs::effects::color_vertical_strips;
/// use photon_rs::native::open_image;
/// use photon_rs::Rgb;
/// let color = Rgb::new(255u8, 0u8, 0u8);
/// let mut img = open_image("img.jpg").expect("File should open");
/// color_vertical_strips(&mut img, 8u8, color);
/// ```
@JS("wasm_bindgen.color_vertical_strips")
external void color_vertical_strips(
    PhotonImage photon_image, num num_strips, Rgb color);

/// Turn an image into an oil painting
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// * `radius` - Radius of each paint particle
/// * `intesnity` - How artsy an Image should be
/// # Example
/// ```no_run
/// // For example, to oil an image of type `PhotonImage`:
/// use photon_rs::effects::oil;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// oil(&mut img, 4i32, 55.0);
/// ```
@JS("wasm_bindgen.oil")
external void oil(PhotonImage photon_image, num radius, num intensity);

/// Turn an image into an frosted glass see through
/// # Arguments
/// * `img` - A PhotonImage that contains a view into the image.
/// # Example
/// ```no_run
/// // For example, to turn an image of type `PhotonImage` into frosted glass see through:
/// use photon_rs::effects::frosted_glass;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// frosted_glass(&mut img);
/// ```
@JS("wasm_bindgen.frosted_glass")
external void frosted_glass(PhotonImage photon_image);

/// Apply a monochrome effect of a certain colour.
/// It does so by averaging the R, G, and B values of a pixel, and then adding a
/// separate value to that averaged value for each channel to produce a tint.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// * `r_offset` - The value to add to the Red channel per pixel.
/// * `g_offset` - The value to add to the Green channel per pixel.
/// * `b_offset` - The value to add to the Blue channel per pixel.
/// # Example
/// ```no_run
/// // For example, to apply a monochrome effect to an image:
/// use photon_rs::monochrome::monochrome;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// monochrome(&mut img, 40_u32, 50_u32, 100_u32);
/// ```
@JS("wasm_bindgen.monochrome")
external void monochrome(
    PhotonImage img, num r_offset, num g_offset, num b_offset);

/// Convert an image to sepia.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to sepia an image of type `PhotonImage`:
/// use photon_rs::monochrome::sepia;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// sepia(&mut img);
/// ```
@JS("wasm_bindgen.sepia")
external void sepia(PhotonImage img);

/// Convert an image to grayscale using the conventional averaging algorithm.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to convert an image of type `PhotonImage` to grayscale:
/// use photon_rs::monochrome::grayscale;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// grayscale(&mut img);
/// ```
@JS("wasm_bindgen.grayscale")
external void grayscale(PhotonImage img);

/// Convert an image to grayscale with a human corrected factor, to account for human vision.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to convert an image of type `PhotonImage` to grayscale with a human corrected factor:
/// use photon_rs::monochrome::grayscale_human_corrected;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// grayscale_human_corrected(&mut img);
/// ```
@JS("wasm_bindgen.grayscale_human_corrected")
external void grayscale_human_corrected(PhotonImage img);

/// Desaturate an image by getting the min/max of each pixel's RGB values.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to desaturate an image:
/// use photon_rs::monochrome::desaturate;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// desaturate(&mut img);
/// ```
@JS("wasm_bindgen.desaturate")
external void desaturate(PhotonImage img);

/// Uses a min. decomposition algorithm to convert an image to greyscale.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to decompose an image with min decomposition:
/// use photon_rs::monochrome::decompose_min;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// decompose_min(&mut img);
/// ```
@JS("wasm_bindgen.decompose_min")
external void decompose_min(PhotonImage img);

/// Uses a max. decomposition algorithm to convert an image to greyscale.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// // For example, to decompose an image with max decomposition:
/// use photon_rs::monochrome::decompose_max;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// decompose_max(&mut img);
/// ```
@JS("wasm_bindgen.decompose_max")
external void decompose_max(PhotonImage img);

/// Employ only a limited number of gray shades in an image.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// * `num_shades` - The number of grayscale shades to be displayed in the image.
/// # Example
/// ```no_run
/// // For example, to limit an image to four shades of gray only:
/// use photon_rs::monochrome::grayscale_shades;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// grayscale_shades(&mut img, 4_u8);
/// ```
@JS("wasm_bindgen.grayscale_shades")
external void grayscale_shades(PhotonImage photon_image, num num_shades);

/// Convert an image to grayscale by setting a pixel's 3 RGB values to the Red channel's value.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::monochrome::r_grayscale;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// r_grayscale(&mut img);
/// ```
@JS("wasm_bindgen.r_grayscale")
external void r_grayscale(PhotonImage photon_image);

/// Convert an image to grayscale by setting a pixel's 3 RGB values to the Green channel's value.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::monochrome::g_grayscale;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// g_grayscale(&mut img);
/// ```
@JS("wasm_bindgen.g_grayscale")
external void g_grayscale(PhotonImage photon_image);

/// Convert an image to grayscale by setting a pixel's 3 RGB values to the Blue channel's value.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// # Example
/// ```no_run
/// use photon_rs::monochrome::b_grayscale;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// b_grayscale(&mut img);
/// ```
@JS("wasm_bindgen.b_grayscale")
external void b_grayscale(PhotonImage photon_image);

/// Convert an image to grayscale by setting a pixel's 3 RGB values to a chosen channel's value.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// * `channel` - A usize representing the channel from 0 to 2. O represents the Red channel, 1 the Green channel, and 2 the Blue channel.
/// # Example
/// To grayscale using only values from the Red channel:
/// ```no_run
/// use photon_rs::monochrome::single_channel_grayscale;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// single_channel_grayscale(&mut img, 0_usize);
/// ```
@JS("wasm_bindgen.single_channel_grayscale")
external void single_channel_grayscale(PhotonImage photon_image, num channel);

/// Threshold an image using a standard thresholding algorithm.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// * `threshold` - The amount the image should be thresholded by from 0 to 255.
/// # Example
/// ```no_run
/// // For example, to threshold an image of type `PhotonImage`:
/// use photon_rs::monochrome::threshold;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// threshold(&mut img, 30_u32);
/// ```
@JS("wasm_bindgen.threshold")
external void threshold(PhotonImage img, num threshold);

/// Add a watermark to an image.
/// # Arguments
/// * `img` - A DynamicImage that contains a view into the image.
/// * `watermark` - The watermark to be placed onto the `img` image.
/// * `x` - The x coordinate where the watermark's top corner should be positioned.
/// * `y` - The y coordinate where the watermark's top corner should be positioned.
/// # Example
/// ```no_run
/// // For example, to add a watermark to an image at x: 30, y: 40:
/// use photon_rs::multiple::watermark;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// let water_mark = open_image("watermark.jpg").expect("File should open");
/// watermark(&mut img, &water_mark, 30_u32, 40_u32);
/// ```
@JS("wasm_bindgen.watermark")
external void watermark(PhotonImage img, PhotonImage watermark, num x, num y);

/// Blend two images together.
/// The `blend_mode` (3rd param) determines which blending mode to use; change this for varying effects.
/// The blend modes available include: `overlay`, `over`, `atop`, `xor`, `multiply`, `burn`, `soft_light`, `hard_light`,
/// `difference`, `lighten`, `darken`, `dodge`, `plus`, `exclusion` (more to come)
/// NOTE: The first image must be smaller than the second image passed as params.
/// If the first image were larger than the second, then there would be overflowing pixels which would have no corresponding pixels
/// in the second image.
/// # Arguments
/// * `img` - A DynamicImage that contains a view into the image.
/// * `img2` - The 2nd DynamicImage to be blended with the first.
/// * `blend_mode` - The blending mode to use. See above for complete list of blend modes available.
/// # Example
/// ```no_run
/// // For example, to blend two images with the `multiply` blend mode:
/// use photon_rs::multiple::blend;
/// use photon_rs::native::open_image;
/// let mut img = open_image("img.jpg").expect("File should open");
/// let img2 = open_image("img2.jpg").expect("File should open");
/// blend(&mut img, &img2, "multiply");
/// ```
@JS("wasm_bindgen.blend")
external void blend(
    PhotonImage photon_image, PhotonImage photon_image2, String blend_mode);
@JS("wasm_bindgen.create_gradient")
external PhotonImage create_gradient(num width, num height);

/// Apply a gradient to an image.
@JS("wasm_bindgen.apply_gradient")
external void apply_gradient(PhotonImage image);

/// Apply gamma correction.
/// Image manipulation effects in the LCh colour space
/// Effects include:
/// * **saturate** - Saturation increase.
/// * **desaturate** - Desaturate the image.
/// * **shift_hue** - Hue rotation by a specified number of degrees.
/// * **darken** - Decrease the brightness.
/// * **lighten** - Increase the brightness.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// * `mode` - The effect desired to be applied. Choose from: `saturate`, `desaturate`, `shift_hue`, `darken`, `lighten`
/// * `amt` - A float value from 0 to 1 which represents the amount the effect should be increased by.
/// # Example
/// ```no_run
/// // For example to increase the saturation by 10%:
/// use photon_rs::colour_spaces::lch;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// lch(&mut img, "saturate", 0.1_f32);
/// ```
@JS("wasm_bindgen.lch")
external void lch(PhotonImage photon_image, String mode, num amt);

/// Image manipulation effects in the HSL colour space.
/// Effects include:
/// * **saturate** - Saturation increase.
/// * **desaturate** - Desaturate the image.
/// * **shift_hue** - Hue rotation by a specified number of degrees.
/// * **darken** - Decrease the brightness.
/// * **lighten** - Increase the brightness.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// * `mode` - The effect desired to be applied. Choose from: `saturate`, `desaturate`, `shift_hue`, `darken`, `lighten`
/// * `amt` - A float value from 0 to 1 which represents the amount the effect should be increased by.
/// # Example
/// ```no_run
/// // For example to increase the saturation by 10%:
/// use photon_rs::colour_spaces::hsl;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// hsl(&mut img, "saturate", 0.1_f32);
/// ```
@JS("wasm_bindgen.hsl")
external void hsl(PhotonImage photon_image, String mode, num amt);

/// Image manipulation in the HSV colour space.
/// Effects include:
/// * **saturate** - Saturation increase.
/// * **desaturate** - Desaturate the image.
/// * **shift_hue** - Hue rotation by a specified number of degrees.
/// * **darken** - Decrease the brightness.
/// * **lighten** - Increase the brightness.
/// # Arguments
/// * `photon_image` - A PhotonImage.
/// * `mode` - The effect desired to be applied. Choose from: `saturate`, `desaturate`, `shift_hue`, `darken`, `lighten`
/// * `amt` - A float value from 0 to 1 which represents the amount the effect should be increased by.
/// # Example
/// ```no_run
/// // For example to increase the saturation by 10%:
/// use photon_rs::colour_spaces::hsv;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// hsv(&mut img, "saturate", 0.1_f32);
/// ```
@JS("wasm_bindgen.hsv")
external void hsv(PhotonImage photon_image, String mode, num amt);

/// Shift hue by a specified number of degrees in the HSL colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `mode` - A float value from 0 to 1 which is the amount to shift the hue by, or hue rotate by.
/// # Example
/// ```no_run
/// // For example to hue rotate/shift the hue by 120 degrees in the HSL colour space:
/// use photon_rs::colour_spaces::hue_rotate_hsl;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// hue_rotate_hsl(&mut img, 120_f32);
/// ```
@JS("wasm_bindgen.hue_rotate_hsl")
external void hue_rotate_hsl(PhotonImage img, num degrees);

/// Shift hue by a specified number of degrees in the HSV colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `mode` - A float value from 0 to 1 which is the amount to shift the hue by, or hue rotate by.
/// # Example
/// ```no_run
/// // For example to hue rotate/shift the hue by 120 degrees in the HSV colour space:
/// use photon_rs::colour_spaces::hue_rotate_hsv;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// hue_rotate_hsv(&mut img, 120_f32);
/// ```
@JS("wasm_bindgen.hue_rotate_hsv")
external void hue_rotate_hsv(PhotonImage img, num degrees);

/// Shift hue by a specified number of degrees in the LCh colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `mode` - A float value from 0 to 1 which is the amount to shift the hue by, or hue rotate by.
/// # Example
/// ```no_run
/// // For example to hue rotate/shift the hue by 120 degrees in the HSL colour space:
/// use photon_rs::colour_spaces::hue_rotate_lch;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// hue_rotate_lch(&mut img, 120_f32);
/// ```
@JS("wasm_bindgen.hue_rotate_lch")
external void hue_rotate_lch(PhotonImage img, num degrees);

/// Increase the image's saturation by converting each pixel's colour to the HSL colour space
/// and increasing the colour's saturation.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to increase the saturation by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Increasing saturation by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to increase saturation by 10% in the HSL colour space:
/// use photon_rs::colour_spaces::saturate_hsl;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// saturate_hsl(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.saturate_hsl")
external void saturate_hsl(PhotonImage img, num level);

/// Increase the image's saturation in the LCh colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to increase the saturation by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Increasing saturation by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to increase saturation by 40% in the Lch colour space:
/// use photon_rs::colour_spaces::saturate_lch;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// saturate_lch(&mut img, 0.4_f32);
/// ```
@JS("wasm_bindgen.saturate_lch")
external void saturate_lch(PhotonImage img, num level);

/// Increase the image's saturation in the HSV colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level by which to increase the saturation by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Increasing saturation by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to increase saturation by 30% in the HSV colour space:
/// use photon_rs::colour_spaces::saturate_hsv;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// saturate_hsv(&mut img, 0.3_f32);
/// ```
@JS("wasm_bindgen.saturate_hsv")
external void saturate_hsv(PhotonImage img, num level);

/// Lighten an image by a specified amount in the LCh colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to lighten the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Lightening by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to lighten an image by 10% in the LCh colour space:
/// use photon_rs::colour_spaces::lighten_lch;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// lighten_lch(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.lighten_lch")
external void lighten_lch(PhotonImage img, num level);

/// Lighten an image by a specified amount in the HSL colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to lighten the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Lightening by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to lighten an image by 10% in the HSL colour space:
/// use photon_rs::colour_spaces::lighten_hsl;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// lighten_hsl(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.lighten_hsl")
external void lighten_hsl(PhotonImage img, num level);

/// Lighten an image by a specified amount in the HSV colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to lighten the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Lightening by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to lighten an image by 10% in the HSV colour space:
/// use photon_rs::colour_spaces::lighten_hsv;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// lighten_hsv(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.lighten_hsv")
external void lighten_hsv(PhotonImage img, num level);

/// Darken the image by a specified amount in the LCh colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to darken the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Darkening by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to darken an image by 10% in the LCh colour space:
/// use photon_rs::colour_spaces::darken_lch;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// darken_lch(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.darken_lch")
external void darken_lch(PhotonImage img, num level);

/// Darken the image by a specified amount in the HSL colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to darken the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Darkening by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to darken an image by 10% in the HSL colour space:
/// use photon_rs::colour_spaces::darken_hsl;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// darken_hsl(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.darken_hsl")
external void darken_hsl(PhotonImage img, num level);

/// Darken the image's colours by a specified amount in the HSV colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to darken the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Darkening by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to darken an image by 10% in the HSV colour space:
/// use photon_rs::colour_spaces::darken_hsv;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// darken_hsv(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.darken_hsv")
external void darken_hsv(PhotonImage img, num level);

/// Desaturate the image by a specified amount in the HSV colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to desaturate the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Desaturating by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to desaturate an image by 10% in the HSV colour space:
/// use photon_rs::colour_spaces::desaturate_hsv;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// desaturate_hsv(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.desaturate_hsv")
external void desaturate_hsv(PhotonImage img, num level);

/// Desaturate the image by a specified amount in the HSL colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to desaturate the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Desaturating by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to desaturate an image by 10% in the LCh colour space:
/// use photon_rs::colour_spaces::desaturate_hsl;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// desaturate_hsl(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.desaturate_hsl")
external void desaturate_hsl(PhotonImage img, num level);

/// Desaturate the image by a specified amount in the LCh colour space.
/// # Arguments
/// * `img` - A PhotonImage.
/// * `level` - Float value from 0 to 1 representing the level to which to desaturate the image by.
/// The `level` must be from 0 to 1 in floating-point, `f32` format.
/// Desaturating by 80% would be represented by a `level` of 0.8
/// # Example
/// ```no_run
/// // For example to desaturate an image by 10% in the LCh colour space:
/// use photon_rs::colour_spaces::desaturate_lch;
/// use photon_rs::native::open_image;
/// // Open the image. A PhotonImage is returned.
/// let mut img = open_image("img.jpg").expect("File should open");
/// desaturate_lch(&mut img, 0.1_f32);
/// ```
@JS("wasm_bindgen.desaturate_lch")
external void desaturate_lch(PhotonImage img, num level);

/// Mix image with a single color, supporting passing `opacity`.
/// The algorithm comes from Jimp. See `function mix` and `function colorFn` at following link:
/// https://github.com/oliver-moran/jimp/blob/29679faa597228ff2f20d34c5758e4d2257065a3/packages/plugin-color/src/index.js
/// Specifically, result_value = (mix_color_value - origin_value) * opacity + origin_value =
/// mix_color_value * opacity + (1 - opacity) * origin_value for each
/// of RGB channel.
/// # Arguments
/// * `photon_image` - A PhotonImage that contains a view into the image.
/// * `mix_color` - the color to be mixed in, as an RGB value.
/// * `opacity` - the opacity of color when mixed to image. Float value from 0 to 1.
/// # Example
/// ```no_run
/// // For example, to mix an image with rgb (50, 255, 254) and opacity 0.4:
/// use photon_rs::Rgb;
/// use photon_rs::colour_spaces::mix_with_colour;
/// use photon_rs::native::open_image;
/// let mix_colour = Rgb::new(50_u8, 255_u8, 254_u8);
/// let mut img = open_image("img.jpg").expect("File should open");
/// mix_with_colour(&mut img, mix_colour, 0.4_f32);
/// ```
@JS("wasm_bindgen.mix_with_colour")
external void mix_with_colour(
    PhotonImage photon_image, Rgb mix_colour, num opacity);

@JS("wasm_bindgen.SamplingFilter")
class SamplingFilter {
  external static num get Nearest;
  external static num get Triangle;
  external static num get CatmullRom;
  external static num get Gaussian;
  external static num get Lanczos3;
}

/// Provides the image's height, width, and contains the image's raw pixels.
/// For use when communicating between JS and WASM, and also natively.
@JS("wasm_bindgen.PhotonImage")
class PhotonImage {
  // @Ignore
  PhotonImage.fakeConstructor$();
  external void free();

  /// Create a new PhotonImage from a Vec of u8s, which represent raw pixels.
  external factory PhotonImage(Uint8Array raw_pixels, num width, num height);

  /// Create a new PhotonImage from a base64 string.
  external static PhotonImage new_from_base64(String base64);

  /// Create a new PhotonImage from a byteslice.
  external static PhotonImage new_from_byteslice(Uint8Array vec);

  /// Get the width of the PhotonImage.
  external num get_width();

  /// Get the PhotonImage's pixels as a Vec of u8s.
  external Uint8Array get_raw_pixels();

  /// Get the height of the PhotonImage.
  external num get_height();

  /// Convert the PhotonImage to base64.
  external String get_base64();

  /// Convert the PhotonImage's raw pixels to JS-compatible ImageData.
  external ImageData get_image_data();

  /// Convert ImageData to raw pixels, and update the PhotonImage's raw pixels to this.
  external void set_imgdata(ImageData img_data);
}

/// RGB color type.
@JS("wasm_bindgen.Rgb")
class Rgb {
  // @Ignore
  Rgb.fakeConstructor$();
  external void free();

  /// Create a new RGB struct.
  external factory Rgb(num r, num g, num b);

  /// Set the Red value.
  external void set_red(num r);

  /// Get the Green value.
  external void set_green(num g);

  /// Set the Blue value.
  external void set_blue(num b);

  /// Get the Red value.
  external num get_red();

  /// Get the Green value.
  external num get_green();

  /// Get the Blue value.
  external num get_blue();
}

/// RGBA color type.
@JS("wasm_bindgen.Rgba")
class Rgba {
  // @Ignore
  Rgba.fakeConstructor$();
  external void free();

  /// Create a new RGBA struct.
  external factory Rgba(num r, num g, num b, num a);

  /// Set the Red value.
  external void set_red(num r);

  /// Get the Green value.
  external void set_green(num g);

  /// Set the Blue value.
  external void set_blue(num b);

  /// Set the alpha value.
  external void set_alpha(num a);

  /// Get the Red value.
  external num get_red();

  /// Get the Green value.
  external num get_green();

  /// Get the Blue value.
  external num get_blue();

  /// Get the alpha value for this color.
  external num get_alpha();
}

// End module wasm_bindgen
/*declare type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;*/
@anonymous
@JS()
abstract class InitOutput {
  external Memory get memory;
  external void Function(num, num, num) get alter_channel;
  external void Function(num, num) get alter_red_channel;
  external void Function(num, num) get alter_green_channel;
  external void Function(num, num) get alter_blue_channel;
  external void Function(num, num, num, num, num) get alter_two_channels;
  external void Function(num, num, num, num) get alter_channels;
  external void Function(num, num, num) get remove_channel;
  external void Function(num, num) get remove_red_channel;
  external void Function(num, num) get remove_green_channel;
  external void Function(num, num) get remove_blue_channel;
  external void Function(num, num, num) get swap_channels;
  external void Function(num) get invert;
  external void Function(num, num, num) get selective_hue_rotate;
  external void Function(num, num, num) get selective_lighten;
  external void Function(num, num, num) get selective_desaturate;
  external void Function(num, num, num) get selective_saturate;
  external void Function(num, num) get selective_greyscale;
  external void Function(num) get neue;
  external void Function(num) get lix;
  external void Function(num) get ryo;
  external void Function(num, num, num) get filter;
  external void Function(num) get lofi;
  external void Function(num) get pastel_pink;
  external void Function(num) get golden;
  external void Function(num) get cali;
  external void Function(num) get dramatic;
  external void Function(num) get firenze;
  external void Function(num) get obsidian;
  external void Function(num) get noise_reduction;
  external void Function(num) get sharpen;
  external void Function(num) get edge_detection;
  external void Function(num) get identity;
  external void Function(num) get box_blur;
  external void Function(num, num) get gaussian_blur;
  external void Function(num) get detect_horizontal_lines;
  external void Function(num) get detect_vertical_lines;
  external void Function(num) get detect_45_deg_lines;
  external void Function(num) get detect_135_deg_lines;
  external void Function(num) get laplace;
  external void Function(num) get edge_one;
  external void Function(num) get emboss;
  external void Function(num) get sobel_horizontal;
  external void Function(num) get prewitt_horizontal;
  external void Function(num) get sobel_vertical;
  external num Function(num, num, num, num, num) get crop;
  external num Function(num, num, num, num, num) get crop_img_browser;
  external void Function(num) get fliph;
  external void Function(num) get flipv;
  external num Function(num, num, num, num) get resize_img_browser;
  external num Function(num, num, num, num) get resize;
  external num Function(num, num, num) get seam_carve;
  external num Function(num, num, num) get padding_uniform;
  external num Function(num, num, num) get padding_left;
  external num Function(num, num, num) get padding_right;
  external num Function(num, num, num) get padding_top;
  external num Function(num, num, num) get padding_bottom;
  external void Function(num) get JS$__wbg_photonimage_free;
  external num Function(num, num, num, num) get photonimage_new;
  external num Function(num, num) get photonimage_new_from_base64;
  external num Function(num, num) get photonimage_new_from_byteslice;
  external num Function(num) get photonimage_get_width;
  external void Function(num, num) get photonimage_get_raw_pixels;
  external num Function(num) get photonimage_get_height;
  external void Function(num, num) get photonimage_get_base64;
  external num Function(num) get photonimage_get_image_data;
  external void Function(num, num) get photonimage_set_imgdata;
  external void Function(num) get JS$__wbg_rgb_free;
  external num Function(num, num, num) get rgb_new;
  external void Function(num, num) get rgb_set_red;
  external void Function(num, num) get rgb_set_green;
  external void Function(num, num) get rgb_set_blue;
  external num Function(num) get rgb_get_red;
  external num Function(num) get rgb_get_green;
  external num Function(num) get rgb_get_blue;
  external num Function(num, num, num, num) get rgba_new;
  external void Function(num, num) get rgba_set_alpha;
  external num Function(num) get rgba_get_alpha;
  external void Function() get run;
  external num Function(num, num) get get_image_data;
  external void Function(num, num, num) get putImageData;
  external num Function(num, num) get open_image;
  external num Function(num, num) get open_image_test;
  external void Function(num, num) get to_raw_pixels;
  external num Function(num, num) get base64_to_image;
  external void Function(num, num, num) get base64_to_vec;
  external num Function(num) get to_image_data;
  external void Function(num) get JS$__wbg_rgba_free;
  external void Function(num, num) get rgba_set_green;
  external void Function(num, num) get rgba_set_blue;
  external num Function(num) get rgba_get_red;
  external num Function(num) get rgba_get_green;
  external num Function(num) get rgba_get_blue;
  external void Function(num, num) get rgba_set_red;
  external void Function(num, num, num) get offset;
  external void Function(num, num) get offset_red;
  external void Function(num, num) get offset_green;
  external void Function(num, num) get offset_blue;
  external void Function(num, num, num, num) get multiple_offsets;
  external void Function(num) get primary;
  external void Function(num) get colorize;
  external void Function(num) get solarize;
  external num Function(num) get solarize_retimg;
  external void Function(num, num) get inc_brightness;
  external void Function(num, num) get adjust_contrast;
  external void Function(num, num, num, num) get tint;
  external void Function(num, num) get horizontal_strips;
  external void Function(num, num, num) get color_horizontal_strips;
  external void Function(num, num) get vertical_strips;
  external void Function(num, num, num) get color_vertical_strips;
  external void Function(num, num, num) get oil;
  external void Function(num) get frosted_glass;
  external void Function(num, num, num, num) get monochrome;
  external void Function(num) get sepia;
  external void Function(num) get grayscale;
  external void Function(num) get grayscale_human_corrected;
  external void Function(num) get desaturate;
  external void Function(num) get decompose_min;
  external void Function(num) get decompose_max;
  external void Function(num, num) get grayscale_shades;
  external void Function(num) get r_grayscale;
  external void Function(num) get g_grayscale;
  external void Function(num) get b_grayscale;
  external void Function(num, num) get single_channel_grayscale;
  external void Function(num, num) get threshold;
  external void Function(num, num, num, num) get watermark;
  external void Function(num, num, num, num) get blend;
  external num Function(num, num) get create_gradient;
  external void Function(num) get apply_gradient;
  external void Function(num, num, num, num) get lch;
  external void Function(num, num, num, num) get hsl;
  external void Function(num, num, num, num) get hsv;
  external void Function(num, num) get hue_rotate_hsl;
  external void Function(num, num) get hue_rotate_hsv;
  external void Function(num, num) get hue_rotate_lch;
  external void Function(num, num) get saturate_hsl;
  external void Function(num, num) get saturate_lch;
  external void Function(num, num) get saturate_hsv;
  external void Function(num, num) get lighten_lch;
  external void Function(num, num) get lighten_hsl;
  external void Function(num, num) get lighten_hsv;
  external void Function(num, num) get darken_lch;
  external void Function(num, num) get darken_hsl;
  external void Function(num, num) get darken_hsv;
  external void Function(num, num) get desaturate_hsv;
  external void Function(num, num) get desaturate_hsl;
  external void Function(num, num) get desaturate_lch;
  external void Function(num, num, num) get mix_with_colour;
  external num Function(num) get JS$__wbindgen_malloc;
  external num Function(num, num, num) get JS$__wbindgen_realloc;
  external num Function(num) get JS$__wbindgen_add_to_stack_pointer;
  external void Function(num, num) get JS$__wbindgen_free;
  external void Function(num) get JS$__wbindgen_exn_store;
  external factory InitOutput(
      {Memory memory,
      void Function(num, num, num) alter_channel,
      void Function(num, num) alter_red_channel,
      void Function(num, num) alter_green_channel,
      void Function(num, num) alter_blue_channel,
      void Function(num, num, num, num, num) alter_two_channels,
      void Function(num, num, num, num) alter_channels,
      void Function(num, num, num) remove_channel,
      void Function(num, num) remove_red_channel,
      void Function(num, num) remove_green_channel,
      void Function(num, num) remove_blue_channel,
      void Function(num, num, num) swap_channels,
      void Function(num) invert,
      void Function(num, num, num) selective_hue_rotate,
      void Function(num, num, num) selective_lighten,
      void Function(num, num, num) selective_desaturate,
      void Function(num, num, num) selective_saturate,
      void Function(num, num) selective_greyscale,
      void Function(num) neue,
      void Function(num) lix,
      void Function(num) ryo,
      void Function(num, num, num) filter,
      void Function(num) lofi,
      void Function(num) pastel_pink,
      void Function(num) golden,
      void Function(num) cali,
      void Function(num) dramatic,
      void Function(num) firenze,
      void Function(num) obsidian,
      void Function(num) noise_reduction,
      void Function(num) sharpen,
      void Function(num) edge_detection,
      void Function(num) identity,
      void Function(num) box_blur,
      void Function(num, num) gaussian_blur,
      void Function(num) detect_horizontal_lines,
      void Function(num) detect_vertical_lines,
      void Function(num) detect_45_deg_lines,
      void Function(num) detect_135_deg_lines,
      void Function(num) laplace,
      void Function(num) edge_one,
      void Function(num) emboss,
      void Function(num) sobel_horizontal,
      void Function(num) prewitt_horizontal,
      void Function(num) sobel_vertical,
      num Function(num, num, num, num, num) crop,
      num Function(num, num, num, num, num) crop_img_browser,
      void Function(num) fliph,
      void Function(num) flipv,
      num Function(num, num, num, num) resize_img_browser,
      num Function(num, num, num, num) resize,
      num Function(num, num, num) seam_carve,
      num Function(num, num, num) padding_uniform,
      num Function(num, num, num) padding_left,
      num Function(num, num, num) padding_right,
      num Function(num, num, num) padding_top,
      num Function(num, num, num) padding_bottom,
      num Function(num, num, num, num) photonimage_new,
      num Function(num, num) photonimage_new_from_base64,
      num Function(num, num) photonimage_new_from_byteslice,
      num Function(num) photonimage_get_width,
      void Function(num, num) photonimage_get_raw_pixels,
      num Function(num) photonimage_get_height,
      void Function(num, num) photonimage_get_base64,
      num Function(num) photonimage_get_image_data,
      void Function(num, num) photonimage_set_imgdata,
      num Function(num, num, num) rgb_new,
      void Function(num, num) rgb_set_red,
      void Function(num, num) rgb_set_green,
      void Function(num, num) rgb_set_blue,
      num Function(num) rgb_get_red,
      num Function(num) rgb_get_green,
      num Function(num) rgb_get_blue,
      num Function(num, num, num, num) rgba_new,
      void Function(num, num) rgba_set_alpha,
      num Function(num) rgba_get_alpha,
      void Function() run,
      num Function(num, num) get_image_data,
      void Function(num, num, num) putImageData,
      num Function(num, num) open_image,
      num Function(num, num) open_image_test,
      void Function(num, num) to_raw_pixels,
      num Function(num, num) base64_to_image,
      void Function(num, num, num) base64_to_vec,
      num Function(num) to_image_data,
      void Function(num, num) rgba_set_green,
      void Function(num, num) rgba_set_blue,
      num Function(num) rgba_get_red,
      num Function(num) rgba_get_green,
      num Function(num) rgba_get_blue,
      void Function(num, num) rgba_set_red,
      void Function(num, num, num) offset,
      void Function(num, num) offset_red,
      void Function(num, num) offset_green,
      void Function(num, num) offset_blue,
      void Function(num, num, num, num) multiple_offsets,
      void Function(num) primary,
      void Function(num) colorize,
      void Function(num) solarize,
      num Function(num) solarize_retimg,
      void Function(num, num) inc_brightness,
      void Function(num, num) adjust_contrast,
      void Function(num, num, num, num) tint,
      void Function(num, num) horizontal_strips,
      void Function(num, num, num) color_horizontal_strips,
      void Function(num, num) vertical_strips,
      void Function(num, num, num) color_vertical_strips,
      void Function(num, num, num) oil,
      void Function(num) frosted_glass,
      void Function(num, num, num, num) monochrome,
      void Function(num) sepia,
      void Function(num) grayscale,
      void Function(num) grayscale_human_corrected,
      void Function(num) desaturate,
      void Function(num) decompose_min,
      void Function(num) decompose_max,
      void Function(num, num) grayscale_shades,
      void Function(num) r_grayscale,
      void Function(num) g_grayscale,
      void Function(num) b_grayscale,
      void Function(num, num) single_channel_grayscale,
      void Function(num, num) threshold,
      void Function(num, num, num, num) watermark,
      void Function(num, num, num, num) blend,
      num Function(num, num) create_gradient,
      void Function(num) apply_gradient,
      void Function(num, num, num, num) lch,
      void Function(num, num, num, num) hsl,
      void Function(num, num, num, num) hsv,
      void Function(num, num) hue_rotate_hsl,
      void Function(num, num) hue_rotate_hsv,
      void Function(num, num) hue_rotate_lch,
      void Function(num, num) saturate_hsl,
      void Function(num, num) saturate_lch,
      void Function(num, num) saturate_hsv,
      void Function(num, num) lighten_lch,
      void Function(num, num) lighten_hsl,
      void Function(num, num) lighten_hsv,
      void Function(num, num) darken_lch,
      void Function(num, num) darken_hsl,
      void Function(num, num) darken_hsv,
      void Function(num, num) desaturate_hsv,
      void Function(num, num) desaturate_hsl,
      void Function(num, num) desaturate_lch,
      void Function(num, num, num) mix_with_colour});
}

@JS()
abstract class Promise<T> {
  external factory Promise(
      void executor(void resolve(T result), Function reject));
  external Promise then(void onFulfilled(T result), [Function onRejected]);
}
