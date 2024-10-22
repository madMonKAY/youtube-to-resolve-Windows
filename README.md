# youtube-to-resolve-Windows

This lua provides a user interface for downloading videos from YouTube and other platforms directly into Davinci Resolve using `yt-dlp`. It allows users to input a video URL and download the video with specified codecs, managing files effectively within a project structure.

## Features

- Download videos from various platforms, primarily YouTube.
- Supports playlists and multiple video formats.
- Easy-to-use graphical interface for inputting URLs and managing downloads.
- Automatically adds downloaded media files to your media pool.

## Dependencies

Before using this script, ensure you have the following dependencies installed:

1. **[yt-dlp](https://github.com/yt-dlp/yt-dlp)**:
   - A command-line program to download videos from YouTube and other video sites.
   - Installation instructions can be found in the [yt-dlp GitHub repository](https://github.com/yt-dlp/yt-dlp#installation).

2. **[FFmpeg](https://ffmpeg.org/)**:
   - A complete solution to record, convert and stream audio and video.
   - Follow the installation instructions on the [FFmpeg website](https://ffmpeg.org/download.html).

## Usage

1. Download the lua file and copy it into `C:\ProgramData\Blackmagic Design\DaVinci Resolve\Fusion\Scripts\Comp`
2. Ensure that yt-dlp and ffmpeg are installed and available in your system's PATH.
3. In Davinci Resolve go to: `Workspace > Scripts > ytdlp-Resolve


# Changes

## Version Update: From `youtube-dl` to `yt-dlp` Integration

1. **Download Command Execution**:
   - Changed command execution from `youtube-dl` to `yt-dlp` with updated parameters for video and audio codec specifications to ensure compatibility with Davinci Resolve.
   - Improved command formation for better compatibility with special characters.

2. **Input Handling**:
   - Removed the format selection feature. The `Get Formats` button and associated `TextEdit` for displaying formats were removed.

3. **URL Handling**:
   - Added validation for YouTube URLs to ensure they are valid and to trim any parameters after an `&`.
   - Enclosed the URL in double quotes in the command to properly handle special characters.

4. **File Handling**:
   - Updated file retrieval logic to handle multiple files, especially for playlists:
     - Implemented a loop to read all downloaded files from the output directory.
     - Added each file to the media pool rather than just the first one.
   - Introduced debugging messages to log which files were found and added to the media pool.

5. **Various UI changes**:
   - Changed window title from `"youtube-dl"` to `"Import from YouTube'"`.
   - Decreased the height of the window from `600` to `75`.
   - Adjusted weights in the UI components to improve layout:
     - `Weight` of the input URL `LineEdit` changed from `1.5` to `2`.
     - `Weight` of the `Download Video` button changed from `1.5` to `1`.

6. **Code Cleanliness**:
   - Improved variable naming for clarity and consistency.
   - Removed unused or commented-out code for better readability.

## Summary
These changes enhance the functionality and usability of the script, particularly in terms of downloading videos and handling playlists. The new version is designed to provide more robust handling of different scenarios and a clearer interface for users.

# Original Author

This is based on the lua created by [fixinPost](https://github.com/fixinPost). Special thanks for their foundational work that made this adaptation possible.

