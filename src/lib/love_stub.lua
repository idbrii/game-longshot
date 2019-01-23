-- Don't use this file!
-- Just to make ctags/ltags generate love api info.

-- vim: set fdm=marker:
local love = {} -- {{{1

local audio = {} -- {{{2

-- 
-- returns: effects	(table)	The list of the names of the currently enabled effects.
function love.audio.getActiveEffects()
end

-- 
-- returns: count	(number)	The current number of simultaneously playing sources.
function love.audio.getActiveSourceCount()
end

-- 
-- returns: model	(DistanceModel)	The current distance model. The default is 'inverseclamped'.
function love.audio.getDistanceModel()
end

-- 
-- returns: scale	(number)	The current doppler scale factor.
function love.audio.getDopplerScale()
end

-- name	(string)	The name of the effect.
-- 
-- returns: settings	(table)	The settings associated with the effect.
function love.audio.getEffect(name)
end

-- 
-- returns: maximum	(number)	The maximum number of active Effects.
function love.audio.getMaxSceneEffects()
end

-- 
-- returns: maximum	(number)	The maximum number of active Effects per Source.
function love.audio.getMaxSourceEffects()
end

-- 
-- returns: fx	(number)	The X component of the forward vector of the listener orientation.
-- returns: fy	(number)	The Y component of the forward vector of the listener orientation.
-- returns: fz	(number)	The Z component of the forward vector of the listener orientation.
-- returns: ux	(number)	The X component of the up vector of the listener orientation.
-- returns: uy	(number)	The Y component of the up vector of the listener orientation.
-- returns: uz	(number)	The Z component of the up vector of the listener orientation.
function love.audio.getOrientation()
end

-- 
-- returns: x	(number)	The X position of the listener.
-- returns: y	(number)	The Y position of the listener.
-- returns: z	(number)	The Z position of the listener.
function love.audio.getPosition()
end

-- 
-- returns: devices	(table)	The list of RecordingDevices
function love.audio.getRecordingDevices()
end

-- 
-- returns: numSources	(number)	The number of sources which are currently playing or paused.
function love.audio.getSourceCount()
end

-- 
-- returns: x	(number)	The X velocity of the listener.
-- returns: y	(number)	The Y velocity of the listener.
-- returns: z	(number)	The Z velocity of the listener.
function love.audio.getVelocity()
end

-- 
-- returns: volume	(number)	The current master volume.
function love.audio.getVolume()
end

-- 
-- returns: supported	(boolean)	True if Effects are supported, false otherwise.
function love.audio.isEffectsSupported()
end

-- filename	(string)	The filepath to the audio file.
-- type	(SourceType)	Streaming or static source.
-- 
-- returns: source	(Source)	A new Source that can play the specified audio.
function love.audio.newSource(filename, type)
end

-- file	(File)	A File pointing to an audio file.
-- type	(SourceType)	Streaming or static source.
-- 
-- returns: source	(Source)	A new Source that can play the specified audio.
function love.audio.newSource(file, type)
end

-- decoder	(Decoder)	The Decoder to create a Source from.
-- 
-- returns: source	(Source)	A new Source that can play the specified audio.
function love.audio.newSource(decoder)
end

-- fileData	(FileData)	The FileData to create a Source from.
-- 
-- returns: source	(Source)	A new Source that can play the specified audio.
function love.audio.newSource(fileData)
end

-- soundData	(SoundData)	The SoundData to create a Source from.
-- 
-- returns: source	(Source)	A new Source that can play the specified audio. The SourceType of the returned audio is "static".
function love.audio.newSource(soundData)
end

-- samplerate	(number)	Number of samples per second when playing.
-- bitdepth	(number)	Bits per sample (8 or 16).
-- channels	(number)	1 for mono, 2 for stereo.
-- buffercount	(number)	The number of buffers that can be queued up at any given time with Source:queue. Cannot be greater than 64. A sensible default (~8) is chosen if no value is specified.
-- 
-- returns: source	(Source)	The new Source usable with Source:queue.
function love.audio.newQueueableSource(samplerate, bitdepth, channels, buffercount)
end

-- 
function love.audio.pause()
end

-- source	(Source)	The source on which to pause the playback.
-- 
function love.audio.pause(source)
end

-- source	(Source)	The Source to play.
-- 
function love.audio.play(source)
end

-- model	(DistanceModel)	The new distance model.
-- 
function love.audio.setDistanceModel(model)
end

-- scale	(number)	The new doppler scale factor. The scale must be greater than 0.
-- 
function love.audio.setDopplerScale(scale)
end

-- name	(string)	The name of the effect.
-- settings	(table)	The settings to use for this effect, with the following fields:
-- 
-- returns: success	(boolean)	Whether the effect was successfully created.
function love.audio.setEffect(name, settings)
end

-- name	(string)	The name of the effect.
-- enabled	(boolean)	If false and the given effect name was previously set, disables the effect.
-- 
-- returns: success	(boolean)	Whether the Effect was successfully disabled.
function love.audio.setEffect(name, enabled)
end

-- mix	(boolean)	True to enable mixing, false to disable it.
-- 
-- returns: success	(boolean)	True if the change succeeded, false otherwise.
function love.audio.setMixWithSystem(mix)
end

-- fx	(number)	The X component of the forward vector of the listener orientation.
-- fy	(number)	The Y component of the forward vector of the listener orientation.
-- fz	(number)	The Z component of the forward vector of the listener orientation.
-- ux	(number)	The X component of the up vector of the listener orientation.
-- uy	(number)	The Y component of the up vector of the listener orientation.
-- uz	(number)	The Z component of the up vector of the listener orientation.
-- 
function love.audio.setOrientation(fx, fy, fz, ux, uy, uz)
end

-- x	(number)	The X position of the listener.
-- y	(number)	The Y position of the listener.
-- z	(number)	The Z position of the listener.
-- 
function love.audio.setPosition(x, y, z)
end

-- x	(number)	The X velocity of the listener.
-- y	(number)	The Y velocity of the listener.
-- z	(number)	The Z velocity of the listener.
-- 
function love.audio.setVelocity(x, y, z)
end

-- volume	(number)	1.0f is max and 0.0f is off.
-- 
function love.audio.setVolume(volume)
end

-- 
function love.audio.stop()
end

-- source	(Source)	The source on which to stop the playback.
-- 
function love.audio.stop(source)
end
local data = {} -- {{{2

-- container	(ContainerType)	What type to return the compressed data as.
-- format	(CompressedDataFormat)	The format to use when compressing the string.
-- rawstring	(string)	The raw (un-compressed) string to compress.
-- level	(number)	The level of compression to use, between 0 and 9. -1 indicates the default level. The meaning of this argument depends on the compression format being used.
-- 
-- returns: compressedData	(CompressedData or string)	CompressedData/string which contains the compressed version of data.
function love.data.compress(container, format, rawstring, level)
end

-- container	(ContainerType)	What type to return the compressed data as.
-- format	(CompressedDataFormat)	The format to use when compressing the data.
-- data	(Data)	A Data object containing the raw (un-compressed) data to compress.
-- level	(number)	The level of compression to use, between 0 and 9. -1 indicates the default level. The meaning of this argument depends on the compression format being used.
-- 
-- returns: compressedData	(CompressedData or string)	CompressedData/string which contains the compressed version of data.
function love.data.compress(container, format, data, level)
end

-- containerType	(ContainerType)	What type to return the decoded data as.
-- format	(EncodeFormat)	The format of the input data.
-- sourceString	(string)	The raw (encoded) data to decode.
-- 
-- returns: decoded	(Variant)	ByteData/string which contains the decoded version of source.
function love.data.decode(containerType, format, sourceString)
end

-- containerType	(ContainerType)	What type to return the decoded data as.
-- format	(EncodeFormat)	The format of the input data.
-- sourceData	(Data)	The raw (encoded) data to decode.
-- 
-- returns: decoded	(Variant)	ByteData/string which contains the decoded version of source.
function love.data.decode(containerType, format, sourceData)
end

-- container	(ContainerType)	What type to return the decompressed data as.
-- compressedData	(CompressedData)	The compressed data to decompress.
-- 
-- returns: rawstring	(string)	A string containing the raw decompressed data.
function love.data.decompress(container, compressedData)
end

-- container	(ContainerType)	What type to return the decompressed data as.
-- format	(CompressedDataFormat)	The format that was used to compress the given string.
-- compressedstring	(string)	A string containing data previously compressed with love.data.compress.
-- 
-- returns: rawstring	(string)	A string containing the raw decompressed data.
function love.data.decompress(container, format, compressedstring)
end

-- container	(ContainerType)	What type to return the decompressed data as.
-- format	(CompressedDataFormat)	The format that was used to compress the given data.
-- data	(Data)	A Data object containing data previously compressed with love.data.compress.
-- 
-- returns: rawstring	(string)	A string containing the raw decompressed data.
function love.data.decompress(container, format, data)
end

-- containerType	(ContainerType)	What type to return the encoded data as.
-- format	(EncodeFormat)	The format of the output data.
-- sourceString	(string)	The raw data to encode.
-- lineLength	(number)	The maximum line length of the output. Only supported for base64, ignored if 0.
-- 
-- returns: encoded	(Variant)	ByteData/string which contains the encoded version of source.
function love.data.encode(containerType, format, sourceString, lineLength)
end

-- containerType	(ContainerType)	What type to return the encoded data as.
-- format	(EncodeFormat)	The format of the output data.
-- sourceData	(Data)	The raw data to encode.
-- lineLength	(number)	The maximum line length of the output. Only supported for base64, ignored if 0.
-- 
-- returns: encoded	(Variant)	ByteData/string which contains the encoded version of source.
function love.data.encode(containerType, format, sourceData, lineLength)
end

-- hashFunction	(HashFunction)	Hash algorithm to use.
-- string	(string)	String to hash.
-- 
-- returns: rawdigest	(string)	Raw message digest string.
function love.data.hash(hashFunction, string)
end

-- hashFunction	(HashFunction)	Hash algorithm to use.
-- data	(Data)	Data to hash.
-- 
-- returns: rawdigest	(string)	Raw message digest string.
function love.data.hash(hashFunction, data)
end
local event = {} -- {{{2

-- 
function love.event.clear()
end

-- 
-- returns: i	(function)	Iterator function usable in a for loop.
function love.event.poll()
end

-- 
function love.event.pump()
end

-- e	(Event)	The name of the event.
-- a	(Variant)	First event argument.
-- b	(Variant)	Second event argument.
-- c	(Variant)	Third event argument.
-- d	(Variant)	Fourth event argument.
-- 
function love.event.push(e, a, b, c, d)
end

-- 
function love.event.quit()
end

-- exitstatus	(number)	The program exit status to use when closing the application.
-- 
function love.event.quit(exitstatus)
end

-- "restart"	(string)	Restarts the game without relaunching the executable. This cleanly shuts down the main Lua state instance and creates a brand new one.
-- 
function love.event.quit("restart")
end

-- 
-- returns: e	(Event)	The type of event.
-- returns: a	(Variant)	First event argument.
-- returns: b	(Variant)	Second event argument.
-- returns: c	(Variant)	Third event argument.
-- returns: d	(Variant)	Fourth event argument.
function love.event.wait()
end
local filesystem = {} -- {{{2

-- name	(string)	The name (and path) of the file.
-- data	(string)	The data that should be written to the file
-- size	(number)	How many bytes to write.
-- 
-- returns: success	(boolean)	True if the operation was successful, or nil if there was an error.
-- returns: errormsg	(string)	The error message on failure.
function love.filesystem.append(name, data, size)
end

-- 
-- returns: enable	(boolean)	Whether love.filesystem follows symbolic links.
function love.filesystem.areSymlinksEnabled()
end

-- name	(string)	The directory to create.
-- 
-- returns: success	(boolean)	True if the directory was created, false if not.
function love.filesystem.createDirectory(name)
end

-- 
-- returns: path	(string)	The path of the application data directory.
function love.filesystem.getAppdataDirectory()
end

-- 
-- returns: paths	(string)	The paths that the require function will check for c libraries in love's filesystem.
function love.filesystem.getCRequirePath()
end

-- dir	(string)	The directory.
-- 
-- returns: items	(table)	A sequence with the names of all files and subdirectories as strings.
function love.filesystem.getDirectoryItems(dir)
end

-- name	(string)	The identity that is used as write directory.
-- 
function love.filesystem.getIdentity(name)
end

-- path	(string)	The file or directory path to check.
-- 
-- returns: info	(table)	A table containing information about the specified path, or nil if nothing exists at the path. The table contains the following fields:
function love.filesystem.getInfo(path)
end

-- path	(string)	The file or directory path to check.
-- info	(table)	A table which will be filled in with info about the specified path.
-- 
-- returns: info	(table)	A table containing information about the specified path, or nil if nothing exists at the path. The table contains the following fields:
function love.filesystem.getInfo(path, info)
end

-- filepath	(string)	The filepath to get the directory of.
-- 
-- returns: realdir	(string)	The platform-specific full path of the directory containing the filepath.
function love.filesystem.getRealDirectory(filepath)
end

-- 
-- returns: paths	(string)	The paths that the require function will check in love's filesystem.
function love.filesystem.getRequirePath()
end

-- 
-- returns: path	(string)	The absolute path to the save directory.
function love.filesystem.getSaveDirectory()
end

-- 
-- returns: path	(string)	The full platform-dependent path of the .love file or directory.
function love.filesystem.getSource()
end

-- 
-- returns: path	(string)	The full platform-dependent path of the directory containing the .love file.
function love.filesystem.getSourceBaseDirectory()
end

-- 
-- returns: path	(string)	The path of the user's directory.
function love.filesystem.getUserDirectory()
end

-- 
-- returns: path	(string)	The current working directory.
function love.filesystem.getWorkingDirectory()
end

-- appname	(string)	The name of the application binary, typically love.
-- 
function love.filesystem.init(appname)
end

-- 
-- returns: fused	(boolean)	True if the game is in fused mode, false otherwise.
function love.filesystem.isFused()
end

-- name	(string)	The name (and path) of the file.
-- 
-- returns: iterator	(function)	A function that iterates over all the lines in the file.
function love.filesystem.lines(name)
end

-- name	(string)	The name (and path) of the file.
-- errormsg	(string)	The error message if file could not be opened.
-- 
-- returns: chunk	(function)	The loaded chunk.
function love.filesystem.load(name, errormsg)
end

-- archive	(string)	The folder or zip file in the game's save directory to mount.
-- mountpoint	(string)	The new path the archive will be mounted to.
-- 
-- returns: success	(boolean)	True if the archive was successfully mounted, false otherwise.
function love.filesystem.mount(archive, mountpoint)
end

-- archive	(string)	The folder or zip file in the game's save directory to mount.
-- mountpoint	(string)	The new path the archive will be mounted to.
-- appendToPath	(string)	Whether the archive will be searched when reading a filepath before or after already-mounted archives. This includes the game's source and save directories.
-- 
-- returns: success	(boolean)	True if the archive was successfully mounted, false otherwise.
function love.filesystem.mount(archive, mountpoint, appendToPath)
end

-- filename	(string)	The filename of the file to read.
-- mode	(FileMode)	The mode to open the file in.
-- 
-- returns: file	(File)	The new File object, or nil if an error occurred.
-- returns: errorstr	(string)	The error string if an error occurred.
function love.filesystem.newFile(filename, mode)
end

-- contents	(string)	The contents of the file.
-- name	(string)	The name of the file.
-- 
-- returns: data	(FileData)	Your new FileData.
function love.filesystem.newFileData(contents, name)
end

-- filepath	(string)	Path to the file.
-- 
-- returns: data	(FileData)	The new FileData, or nil if an error occurred.
-- returns: err	(string)	The error string, if an error occurred.
function love.filesystem.newFileData(filepath)
end

-- name	(string)	The name (and path) of the file.
-- bytes	(number)	How many bytes to read.
-- 
-- returns: contents	(string)	The file contents.
-- returns: size	(number)	How many bytes have been read.
function love.filesystem.read(name, bytes)
end

-- name	(string)	The file or directory to remove.
-- 
-- returns: success	(boolean)	True if the file/directory was removed, false otherwise.
function love.filesystem.remove(name)
end

-- paths	(string)	The paths that the require function will check in love's filesystem.
-- 
function love.filesystem.setCRequirePath(paths)
end

-- name	(string)	The new identity that will be used as write directory.
-- appendToPath	(boolean)	Whether the identity directory will be searched when reading a filepath before or after the game's source directory and any currently mounted archives.
-- 
function love.filesystem.setIdentity(name, appendToPath)
end

-- paths	(string)	The paths that the require function will check in love's filesystem.
-- 
function love.filesystem.setRequirePath(paths)
end

-- path	(string)	Absolute path to the game's source folder.
-- 
function love.filesystem.setSource(path)
end

-- enable	(boolean)	Whether love.filesystem should follow symbolic links.
-- 
function love.filesystem.setSymlinksEnabled(enable)
end

-- archive	(string)	The folder or zip file in the game's save directory which is currently mounted.
-- 
-- returns: success	(boolean)	True if the archive was successfully unmounted, false otherwise.
function love.filesystem.unmount(archive)
end

-- name	(string)	The name (and path) of the file.
-- data	(string)	The string data to write to the file.
-- size	(number)	How many bytes to write.
-- 
-- returns: success	(boolean)	If the operation was successful.
-- returns: message	(string)	Error message if operation was unsuccessful.
function love.filesystem.write(name, data, size)
end

-- name	(string)	The name (and path) of the file.
-- data	(Data)	The Data object to write to the file.
-- size	(number)	How many bytes to write.
-- 
-- returns: success	(boolean)	If the operation was successful.
-- returns: message	(string)	Error message if operation was unsuccessful.
function love.filesystem.write(name, data, size)
end
local graphics = {} -- {{{2

-- drawmode	(DrawMode)	How to draw the arc.
-- x	(number)	The position of the center along x-axis.
-- y	(number)	The position of the center along y-axis.
-- radius	(number)	Radius of the arc.
-- angle1	(number)	The angle at which the arc begins.
-- angle2	(number)	The angle at which the arc terminates.
-- segments	(number)	The number of segments used for drawing the arc.
-- 
function love.graphics.arc(drawmode, x, y, radius, angle1, angle2, segments)
end

-- drawmode	(DrawMode)	How to draw the arc.
-- arctype	(ArcType)	The type of arc to draw.
-- x	(number)	The position of the center along x-axis.
-- y	(number)	The position of the center along y-axis.
-- radius	(number)	Radius of the arc.
-- angle1	(number)	The angle at which the arc begins.
-- angle2	(number)	The angle at which the arc terminates.
-- segments	(number)	The number of segments used for drawing the arc.
-- 
function love.graphics.arc(drawmode, arctype, x, y, radius, angle1, angle2, segments)
end

-- transform	(Transform)	The Transform object to apply to the current graphics coordinate transform.
-- 
function love.graphics.applyTransform(transform)
end

-- filename	(string)	The filename to save the screenshot to. The encoded image type is determined based on the extension of the filename, and must be one of the ImageFormats.
-- 
function love.graphics.captureScreenshot(filename)
end

-- callback	(function)	Function which gets called once the screenshot has been captured. An ImageData is passed into the function as its only argument.
-- 
function love.graphics.captureScreenshot(callback)
end

-- channel	(Channel)	The Channel to push the generated ImageData to.
-- 
function love.graphics.captureScreenshot(channel)
end

-- mode	(DrawMode)	How to draw the circle.
-- x	(number)	The position of the center along x-axis.
-- y	(number)	The position of the center along y-axis.
-- radius	(number)	The radius of the circle.
-- 
function love.graphics.circle(mode, x, y, radius)
end

-- mode	(DrawMode)	How to draw the circle.
-- x	(number)	The position of the center along x-axis.
-- y	(number)	The position of the center along y-axis.
-- radius	(number)	The radius of the circle.
-- segments	(number)	The number of segments used for drawing the circle. Note: The default variable for the segments parameter varies between different versions of LÖVE.
-- 
function love.graphics.circle(mode, x, y, radius, segments)
end

-- 
function love.graphics.clear()
end

-- r	(number)	The red channel of the color to clear the screen to.
-- g	(number)	The green channel of the color to clear the screen to.
-- b	(number)	The blue channel of the color to clear the screen to.
-- a	(number)	The alpha channel of the color to clear the screen to.
-- 
function love.graphics.clear(r, g, b, a)
end

-- color	(table)	A table in the form of {r, g, b, a} containing the color to clear the first active Canvas to.
-- ...	(table)	Additional tables for each active Canvas.
-- 
function love.graphics.clear(color, ...)
end

-- discardcolor	(boolean)	Whether to discard the texture(s) of the active Canvas(es) (the contents of the screen if no Canvas is active).
-- discardstencil	(boolean)	Whether to discard the contents of the stencil buffer of the screen / active Canvas.
-- 
function love.graphics.discard(discardcolor, discardstencil)
end

-- discardcolors	(table)	An array containing boolean values indicating whether to discard the texture of each active Canvas, when multiple simultaneous Canvases are active.
-- discardstencil	(boolean)	Whether to discard the contents of the stencil buffer of the screen / active Canvas.
-- 
function love.graphics.discard(discardcolors, discardstencil)
end

-- drawable	(Drawable)	A drawable object.
-- x	(number)	The position to draw the object (x-axis).
-- y	(number)	The position to draw the object (y-axis).
-- r	(number)	Orientation (radians).
-- sx	(number)	Scale factor (x-axis). Can be negative.
-- sy	(number)	Scale factor (y-axis). Can be negative.
-- ox	(number)	Origin offset (x-axis). (A value of 20 would effectively move your drawable object 20 pixels to the left.)
-- oy	(number)	Origin offset (y-axis). (A value of 20 would effectively move your drawable object 20 pixels up.)
-- kx	(number)	Shearing factor (x-axis).
-- ky	(number)	Shearing factor (y-axis).
-- 
function love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- texture	(Texture)	A Texture (Image or Canvas) to texture the Quad with.
-- quad	(Quad)	The Quad to draw on screen.
-- x	(number)	The position to draw the object (x-axis).
-- y	(number)	The position to draw the object (y-axis).
-- r	(number)	Orientation (radians).
-- sx	(number)	Scale factor (x-axis). Can be negative.
-- sy	(number)	Scale factor (y-axis). Can be negative.
-- ox	(number)	Origin offset (x-axis).
-- oy	(number)	Origin offset (y-axis)
-- kx	(number)	Shearing factor (x-axis).
-- ky	(number)	Shearing factor (y-axis).
-- 
function love.graphics.draw(texture, quad, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- mesh	(Mesh)	The mesh to render.
-- instancecount	(number)	The number of instances to render.
-- x	(number)	The position to draw the instances (x-axis).
-- y	(number)	The position to draw the instances (y-axis).
-- r	(number)	Orientation (radians).
-- sx	(number)	Scale factor (x-axis).
-- sy	(number)	Scale factor (y-axis).
-- ox	(number)	Origin offset (x-axis).
-- oy	(number)	Origin offset (y-axis).
-- kx	(number)	Shearing factor (x-axis).
-- ky	(number)	Shearing factor (y-axis).
-- 
function love.graphics.drawInstanced(mesh, instancecount, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- mesh	(Mesh)	The mesh to render.
-- instancecount	(number)	The number of instances to render.
-- transform	(Transform)	A transform object.
-- 
function love.graphics.drawInstanced(mesh, instancecount, transform)
end

-- texture	(Texture)	The Array Texture to draw.
-- layerindex	(number)	The index of the layer to use when drawing.
-- x	(number)	The position to draw the texture (x-axis).
-- y	(number)	The position to draw the texture (y-axis).
-- r	(number)	Orientation (radians).
-- sx	(number)	Scale factor (x-axis).
-- sy	(number)	Scale factor (y-axis).
-- ox	(number)	Origin offset (x-axis).
-- oy	(number)	Origin offset (y-axis).
-- kx	(number)	Shearing factor (x-axis).
-- ky	(number)	Shearing factor (y-axis).
-- 
function love.graphics.drawLayer(texture, layerindex, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- texture	(Texture)	The Array Texture to draw.
-- layerindex	(number)	The index of the layer to use when drawing.
-- quad	(Quad)	The subsection of the texture's layer to use when drawing.
-- x	(number)	The position to draw the texture (x-axis).
-- y	(number)	The position to draw the texture (y-axis).
-- r	(number)	Orientation (radians).
-- sx	(number)	Scale factor (x-axis).
-- sy	(number)	Scale factor (y-axis).
-- ox	(number)	Origin offset (x-axis).
-- oy	(number)	Origin offset (y-axis).
-- kx	(number)	Shearing factor (x-axis).
-- ky	(number)	Shearing factor (y-axis).
-- 
function love.graphics.drawLayer(texture, layerindex, quad, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- texture	(Texture)	The Array Texture to draw.
-- layerindex	(number)	The index of the layer to use when drawing.
-- transform	(Transform)	A transform object.
-- 
function love.graphics.drawLayer(texture, layerindex, transform)
end

-- texture	(Texture)	The Array Texture to draw.
-- layerindex	(number)	The index of the layer to use when drawing.
-- quad	(Quad)	The subsection of the texture's layer to use when drawing.
-- transform	(Transform)	A transform object.
-- 
function love.graphics.drawLayer(texture, layerindex, quad, transform)
end

-- mode	(DrawMode)	How to draw the ellipse.
-- x	(number)	The position of the center along x-axis.
-- y	(number)	The position of the center along y-axis.
-- radiusx	(number)	The radius of the ellipse along the x-axis (half the ellipse's width).
-- radiusy	(number)	The radius of the ellipse along the y-axis (half the ellipse's height).
-- 
function love.graphics.ellipse(mode, x, y, radiusx, radiusy)
end

-- mode	(DrawMode)	How to draw the ellipse.
-- x	(number)	The position of the center along x-axis.
-- y	(number)	The position of the center along y-axis.
-- radiusx	(number)	The radius of the ellipse along the x-axis (half the ellipse's width).
-- radiusy	(number)	The radius of the ellipse along the y-axis (half the ellipse's height).
-- segments	(number)	The number of segments used for drawing the ellipse.
-- 
function love.graphics.ellipse(mode, x, y, radiusx, radiusy, segments)
end

-- 
function love.graphics.flushBatch()
end

-- 
-- returns: r	(number)	The red component (0-255).
-- returns: g	(number)	The green component (0-255).
-- returns: b	(number)	The blue component (0-255).
-- returns: a	(number)	The alpha component (0-255).
function love.graphics.getBackgroundColor()
end

-- 
-- returns: mode	(BlendMode)	The current blend mode.
-- returns: alphamode	(BlendAlphaMode)	The current blend alpha mode – it determines how the alpha of drawn objects affects blending.
function love.graphics.getBlendMode()
end

-- 
-- returns: canvas	(Canvas)	The Canvas set by setCanvas. Returns nil if drawing to the real screen.
function love.graphics.getCanvas()
end

-- readable	(boolean)	If true, the returned formats will only be indicated as supported if love.graphics.newCanvas will work with the readable flag set to true for that format, and vice versa if the parameter is false.
-- 
-- returns: formats	(table)	A table containing CanvasFormats as keys, and a boolean indicating whether the format is supported as values (taking into account the readable parameter). Not all systems support all formats.
function love.graphics.getCanvasFormats(readable)
end

-- 
-- returns: formats	(table)	A table containing CanvasFormats as keys, and a boolean indicating whether the format is supported as values. Not all systems support all formats.
function love.graphics.getCanvasFormats()
end

-- 
-- returns: r	(number)	The red component (0-255).
-- returns: g	(number)	The red component (0-255).
-- returns: b	(number)	The blue component (0-255).
-- returns: a	(number)	The alpha component (0-255).
function love.graphics.getColor()
end

-- 
-- returns: r	(boolean)	Whether the red color component is active when rendering.
-- returns: g	(boolean)	Whether the green color component is active when rendering.
-- returns: b	(boolean)	Whether the blue color component is active when rendering.
-- returns: a	(boolean)	Whether the alpha color component is active when rendering.
function love.graphics.getColorMask()
end

-- 
-- returns: min	(FilterMode)	Filter mode used when scaling the image down.
-- returns: mag	(FilterMode)	Filter mode used when scaling the image up.
-- returns: anisotropy	(number)	Maximum amount of Anisotropic Filtering used.
function love.graphics.getDefaultFilter()
end

-- 
-- returns: comparemode	(CompareMode)	Depth comparison mode used for depth testing.
-- returns: write	(boolean)	Whether to write update / write values to the depth buffer when rendering.
function love.graphics.getDepthMode()
end

-- 
-- returns: width	(number)	The width of the window.
-- returns: height	(number)	The height of the window.
function love.graphics.getDimensions()
end

-- 
-- returns: font	(Font)	The current Font, or nil if none is set.
function love.graphics.getFont()
end

-- 
-- returns: winding	(VertexWinding)	The winding mode to use. The default winding is counterclockwise ("ccw").
function love.graphics.getFrontFaceWinding()
end

-- 
-- returns: height	(number)	The height of the window.
function love.graphics.getHeight()
end

-- 
-- returns: formats	(table)	A table containing PixelFormats as keys, and a boolean indicating whether the format is supported as values. Not all systems support all formats.
function love.graphics.getImageFormats()
end

-- 
-- returns: join	(LineJoin)	The LineJoin style.
function love.graphics.getLineJoin()
end

-- 
-- returns: style	(LineStyle)	The current line style.
function love.graphics.getLineStyle()
end

-- 
-- returns: width	(number)	The current line width.
function love.graphics.getLineWidth()
end

-- 
-- returns: mode	(CullMode)	The Mesh face culling mode in use (whether to render everything, cull back-facing triangles, or cull front-facing triangles).
function love.graphics.getMeshCullMode()
end

-- 
-- returns: shader	(Shader)	The current Shader.
function love.graphics.getShader()
end

-- 
-- returns: depth	(number)	The current depth of the transform and state love.graphics stack.
function love.graphics.getStackDepth()
end

-- 
-- returns: stats	(table)	A table with the following fields:
function love.graphics.getStats()
end

-- 
-- returns: enabled	(boolean)	Whether stencil testing is enabled.
-- returns: inverted	(boolean)	Whether the stencil test is inverted or not.
function love.graphics.getStencilTest()
end

-- 
-- returns: features	(table)	A table containing GraphicsFeature keys, and boolean values indicating whether each feature is supported.
function love.graphics.getSupported()
end

-- 
-- returns: limits	(table)	A table containing GraphicsLimit keys, and number values.
function love.graphics.getSystemLimits()
end

-- 
-- returns: size	(number)	The current point size.
function love.graphics.getPointSize()
end

-- 
-- returns: name	(string)	The name of the renderer, e.g. "OpenGL" or "OpenGL ES".
-- returns: version	(string)	The version of the renderer with some extra driver-dependent version info, e.g. "2.1 INTEL-8.10.44".
-- returns: vendor	(string)	The name of the graphics card vendor, e.g. "Intel Inc".
-- returns: device	(string)	The name of the graphics card, e.g. "Intel HD Graphics 3000 OpenGL Engine".
function love.graphics.getRendererInfo()
end

-- 
-- returns: x	(number)	The x component of the top-left point of the box.
-- returns: y	(number)	The y component of the top-left point of the box.
-- returns: width	(number)	The width of the box.
-- returns: height	(number)	The height of the box.
function love.graphics.getScissor()
end

-- 
-- returns: texturetypes	(table)	A table containing TextureTypes as keys, and a boolean indicating whether the type is supported as values. Not all systems support all types.
function love.graphics.getTextureTypes()
end

-- 
-- returns: width	(number)	The width of the window.
function love.graphics.getWidth()
end

-- x	(number)	The x-coordinate of the upper left corner of the rectangle to intersect with the existing scissor rectangle.
-- y	(number)	The y-coordinate of the upper left corner of the rectangle to intersect with the existing scissor rectangle.
-- width	(number)	The width of the rectangle to intersect with the existing scissor rectangle.
-- height	(number)	The height of the rectangle to intersect with the existing scissor rectangle.
-- 
function love.graphics.intersectScissor(x, y, width, height)
end

-- 
function love.graphics.intersectScissor()
end

-- screenX	(number)	The x component of the screen-space position.
-- screenY	(number)	The y component of the screen-space position.
-- 
-- returns: globalX	(number)	The x component of the position in global coordinates.
-- returns: globalY	(number)	The y component of the position in global coordinates.
function love.graphics.inverseTransformPoint(screenX, screenY)
end

-- 
-- returns: gammacorrect	(boolean)	True if gamma-correct rendering is supported and was enabled in love.conf, false otherwise.
function love.graphics.isGammaCorrect()
end

-- 
-- returns: wireframe	(boolean)	True if wireframe lines are used when drawing, false if it's not.
function love.graphics.isWireframe()
end

-- x1	(number)	The position of first point on the x-axis.
-- y1	(number)	The position of first point on the y-axis.
-- x2	(number)	The position of second point on the x-axis.
-- y2	(number)	The position of second point on the y-axis.
-- ...	(number)	You can continue passing point positions to draw a polyline.
-- 
function love.graphics.line(x1, y1, x2, y2, ...)
end

-- points	(table)	A table of point positions.
-- 
function love.graphics.line(points)
end

-- width	(number)	The width of the Canvas.
-- height	(number)	The height of the Canvas.
-- format	(CanvasFormat)	The desired texture mode of the Canvas.
-- msaa	(number)	The desired number of antialiasing samples used when drawing to the Canvas.
-- 
-- returns: canvas	(Canvas)	A new Canvas object.
function love.graphics.newCanvas(width, height, format, msaa)
end

-- filename	(string)	The filepath to the BMFont or TrueType font file.
-- 
-- returns: font	(Font)	A Font object which can be used to draw text on screen.
function love.graphics.newFont(filename)
end

-- filename	(string)	The filepath to the TrueType font file.
-- size	(number)	The size of the font in pixels.
-- 
-- returns: font	(Font)	A Font object which can be used to draw text on screen.
function love.graphics.newFont(filename, size)
end

-- filename	(string)	The filepath to the BMFont file.
-- imagefilename	(string)	The filepath to the BMFont's image file. If this argument is omitted, the path specified inside the BMFont file will be used.
-- 
-- returns: font	(Font)	A Font object which can be used to draw text on screen.
function love.graphics.newFont(filename, imagefilename)
end

-- size	(number)	The size of the font in pixels.
-- 
-- returns: font	(Font)	A Font object which can be used to draw text on screen.
function love.graphics.newFont(size)
end

-- vertices	(table)	The table filled with vertex information tables for each vertex as follows:
-- mode	(MeshDrawMode)	How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
-- usage	(SpriteBatchUsage)	The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
-- 
-- returns: mesh	(Mesh)	The new Mesh.
function love.graphics.newMesh(vertices, mode, usage)
end

-- vertexcount	(number)	The total number of vertices the Mesh will use. Each vertex is initialized to {0,0, 0,0, 255,255,255,255}.
-- mode	(MeshDrawMode)	How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
-- usage	(SpriteBatchUsage)	The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
-- 
-- returns: mesh	(Mesh)	The new Mesh.
function love.graphics.newMesh(vertexcount, mode, usage)
end

-- vertexformat	(table)	A table in the form of {attribute, ...}. Each attribute is a table which specifies a custom vertex attribute used for each vertex.
-- vertices	(table)	The table filled with vertex information tables for each vertex, in the form of {vertex, ...} where each vertex is a table in the form of {attributecomponent, ...}.
-- mode	(MeshDrawMode)	How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
-- usage	(SpriteBatchUsage)	The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
-- 
-- returns: mesh	(Mesh)	The new Mesh.
function love.graphics.newMesh(vertexformat, vertices, mode, usage)
end

-- vertexformat	(table)	A table in the form of {attribute, ...}. Each attribute is a table which specifies a custom vertex attribute used for each vertex.
-- vertexcount	(number)	The total number of vertices the Mesh will use.
-- mode	(MeshDrawMode)	How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
-- usage	(SpriteBatchUsage)	The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
-- 
-- returns: mesh	(Mesh)	The new Mesh.
function love.graphics.newMesh(vertexformat, vertexcount, mode, usage)
end

-- filename	(string)	The filepath to the image file.
-- 
-- returns: image	(Image)	An Image object which can be drawn on screen.
function love.graphics.newImage(filename)
end

-- imageData	(ImageData)	An ImageData object. The Image will use this ImageData to reload itself when love.window.setMode is called.
-- 
-- returns: image	(Image)	An Image object which can be drawn on screen.
function love.graphics.newImage(imageData)
end

-- compressedImageData	(CompressedImageData)	A CompressedImageData object. The Image will use this CompressedImageData to reload itself when love.window.setMode is called.
-- 
-- returns: image	(Image)	An Image object which can be drawn on screen.
function love.graphics.newImage(compressedImageData)
end

-- filename	(string)	The filepath to the image file (or a FileData or ImageData or CompressedImageData object).
-- flags	(table)	A table containing the following fields:
-- 
-- returns: image	(Image)	An Image object which can be drawn on screen.
function love.graphics.newImage(filename, flags)
end

-- filename	(string)	The filepath to the image file.
-- glyphs	(string)	A string of the characters in the image in order from left to right.
-- 
-- returns: font	(Font)	A Font object which can be used to draw text on screen.
function love.graphics.newImageFont(filename, glyphs)
end

-- imageData	(ImageData)	The ImageData object to create the font from.
-- glyphs	(string)	A string of the characters in the image in order from left to right.
-- 
-- returns: font	(Font)	A Font object which can be used to draw text on screen.
function love.graphics.newImageFont(imageData, glyphs)
end

-- filename	(string)	The filepath to the image file.
-- glyphs	(string)	A string of the characters in the image in order from left to right.
-- extraspacing	(number)	Additional spacing (positive or negative) to apply to each glyph in the Font.
-- 
-- returns: font	(Font)	A Font object which can be used to draw text on screen.
function love.graphics.newImageFont(filename, glyphs, extraspacing)
end

-- texture	(Texture)	The Image or Canvas to use.
-- buffer	(number)	The max number of particles at the same time.
-- 
-- returns: system	(ParticleSystem)	A new ParticleSystem.
function love.graphics.newParticleSystem(texture, buffer)
end

-- code	(string)	The pixel shader or vertex shader code, or a filename pointing to a file with the code.
-- 
-- returns: shader	(Shader)	A Shader object for use in drawing operations.
function love.graphics.newShader(code)
end

-- pixelcode	(string)	The pixel shader code, or a filename pointing to a file with the code.
-- vertexcode	(string)	The vertex shader code, or a filename pointing to a file with the code.
-- 
-- returns: shader	(Shader)	A Shader object for use in drawing operations.
function love.graphics.newShader(pixelcode, vertexcode)
end

-- font	(Font)	The font to use for the text.
-- textstring	(string)	The initial string of text that the new Text object will contain. May be nil.
-- 
-- returns: text	(Text)	The new drawable Text object.
function love.graphics.newText(font, textstring)
end

-- x	(number)	The top-left position along the x-axis.
-- y	(number)	The top-left position along the y-axis.
-- width	(number)	The width of the Quad.
-- height	(number)	The height of the Quad.
-- sw	(number)	The reference width, the width of the Image.
-- sh	(number)	The reference height, the height of the Image.
-- 
-- returns: quad	(Quad)	The new Quad.
function love.graphics.newQuad(x, y, width, height, sw, sh)
end

-- texture	(Texture)	The Image or Canvas to use for the sprites.
-- maxsprites	(number)	The max number of sprites.
-- usage	(SpriteBatchUsage)	The expected usage of the SpriteBatch. The specified usage mode affects the SpriteBatch's memory usage and performance.
-- 
-- returns: spriteBatch	(SpriteBatch)	The new SpriteBatch.
function love.graphics.newSpriteBatch(texture, maxsprites, usage)
end

-- filename	(string)	The file path to the Ogg Theora video file.
-- loadaudio	(boolean)	Whether to try to load the video's audio into an audio Source. If not explicitly set to true or false, it will try without causing an error if the video has no audio.
-- 
-- returns: video	(Video)	A new Video.
function love.graphics.newVideo(filename, loadaudio)
end

-- videostream	(VideoStream)	A video stream object.
-- loadaudio	(boolean)	Whether to try to load the video's audio into an audio Source. If not explicitly set to true or false, it will try without causing an error if the video has no audio.
-- 
-- returns: video	(Video)	A new Video.
function love.graphics.newVideo(videostream, loadaudio)
end

-- 
function love.graphics.origin()
end

-- x	(number)	The position of the first point on the x-axis.
-- y	(number)	The position of the first point on the y-axis.
-- ...	(number)	The x and y coordinates of additional points.
-- 
function love.graphics.points(x, y, ...)
end

-- points	(table)	A table containing multiple point positions, in the form of {x, y, ...}.
-- 
function love.graphics.points(points)
end

-- points	(table)	A table containing multiple individually colored points, in the form of {point, ...}. Each table contains the position and color of a point in the form of {x, y, r, g, b, a}. The color components are optional.
-- 
function love.graphics.points(points)
end

-- mode	(DrawMode)	How to draw the polygon.
-- ...	(number)	The vertices of the polygon.
-- 
function love.graphics.polygon(mode, ...)
end

-- mode	(DrawMode)	How to draw the polygon.
-- vertices	(table)	The vertices of the polygon as a table.
-- 
function love.graphics.polygon(mode, vertices)
end

-- 
function love.graphics.pop()
end

-- 
function love.graphics.present()
end

-- text	(string)	The text to draw.
-- x	(number)	The position to draw the object (x-axis).
-- y	(number)	The position to draw the object (y-axis).
-- r	(number)	Orientation (radians).
-- sx	(number)	Scale factor (x-axis).
-- sy	(number)	Scale factor (y-axis).
-- ox	(number)	Origin offset (x-axis).
-- oy	(number)	Origin offset (y-axis).
-- kx	(number)	Shear factor (x-axis).
-- ky	(number)	Shear factor (y-axis).
-- 
function love.graphics.print(text, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- coloredtext	(table)	A table containing colors and strings to add to the object, in the form of {color1, string1, color2, string2, ...}.
-- x	(number)	The position of the new text on the x-axis.
-- y	(number)	The position of the new text on the y-axis.
-- angle	(number)	The orientation of the object in radians.
-- sx	(number)	Scale factor on the x-axis.
-- sy	(number)	Scale factor on the y-axis.
-- ox	(number)	Origin offset on the x-axis.
-- oy	(number)	Origin offset on the y-axis.
-- kx	(number)	Shearing / skew factor on the x-axis.
-- ky	(number)	Shearing / skew factor on the y-axis.
-- 
function love.graphics.print(coloredtext, x, y, angle, sx, sy, ox, oy, kx, ky)
end

-- text	(string)	A text string.
-- x	(number)	The position on the x-axis.
-- y	(number)	The position on the y-axis.
-- limit	(number)	Wrap the line after this many horizontal pixels.
-- align	(AlignMode)	The alignment.
-- r	(number)	Orientation (radians).
-- sx	(number)	Scale factor (x-axis).
-- sy	(number)	Scale factor (y-axis).
-- ox	(number)	Origin offset (x-axis).
-- oy	(number)	Origin offset (y-axis).
-- kx	(number)	Shear factor (x-axis).
-- ky	(number)	Shear factor (y-axis).
-- 
function love.graphics.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)
end

-- coloredtext	(table)	A table containing colors and strings to add to the object, in the form of {color1, string1, color2, string2, ...}.
-- x	(number)	The position of the new text on the x-axis.
-- y	(number)	The position of the new text on the y-axis.
-- wraplimit	(number)	The maximum width in pixels of the text before it gets automatically wrapped to a new line.
-- align	(AlignMode)	The alignment of the text.
-- angle	(number)	The orientation of the object in radians.
-- sx	(number)	Scale factor on the x-axis.
-- sy	(number)	Scale factor on the y-axis.
-- ox	(number)	Origin offset on the x-axis.
-- oy	(number)	Origin offset on the y-axis.
-- kx	(number)	Shearing / skew factor on the x-axis.
-- ky	(number)	Shearing / skew factor on the y-axis.
-- 
function love.graphics.printf(coloredtext, x, y, wraplimit, align, angle, sx, sy, ox, oy, kx, ky)
end

-- stack	(StackType)	The type of stack to push (e.g. just transformation state, or all love.graphics state).
-- 
function love.graphics.push(stack)
end

-- mode	(DrawMode)	How to draw the rectangle.
-- x	(number)	The position of top-left corner along the x-axis.
-- y	(number)	The position of top-left corner along the y-axis.
-- width	(number)	Width of the rectangle.
-- height	(number)	Height of the rectangle.
-- 
function love.graphics.rectangle(mode, x, y, width, height)
end

-- mode	(DrawMode)	How to draw the rectangle.
-- x	(number)	The position of top-left corner along the x-axis.
-- y	(number)	The position of top-left corner along the y-axis.
-- width	(number)	Width of the rectangle.
-- height	(number)	Height of the rectangle.
-- rx	(number)	The x-axis radius of each round corner. Cannot be greater than half the rectangle's width.
-- ry	(number)	The y-axis radius of each round corner. Cannot be greater than half the rectangle's height.
-- segments	(number)	The number of segments used for drawing the round corners. A default amount will be chosen if no number is given.
-- 
function love.graphics.rectangle(mode, x, y, width, height, rx, ry, segments)
end

-- transform	(Transform)	The Transform object to replace the current graphics coordinate transform with.
-- 
function love.graphics.replaceTransform(transform)
end

-- 
function love.graphics.reset()
end

-- angle	(number)	The amount to rotate the coordinate system in radians.
-- 
function love.graphics.rotate(angle)
end

-- sx	(number)	The scaling in the direction of the x-axis.
-- sy	(number)	The scaling in the direction of the y-axis. If omitted, it defaults to same as parameter sx.
-- 
function love.graphics.scale(sx, sy)
end

-- r	(number)	The red component (0-255).
-- g	(number)	The green component (0-255).
-- b	(number)	The blue component (0-255).
-- a	(number)	The alpha component (0-255).
-- 
function love.graphics.setBackgroundColor(r, g, b, a)
end

-- rgba	(table)	A numerical indexed table with the red, green and blue values as numbers. Alpha is 255 if it is not in the table
-- 
function love.graphics.setBackgroundColor(rgba)
end

-- mode	(BlendMode)	The blend mode to use.
-- 
function love.graphics.setBlendMode(mode)
end

-- mode	(BlendMode)	The blend mode to use.
-- alphamode	(BlendAlphaMode)	What to do with the alpha of drawn objects when blending.
-- 
function love.graphics.setBlendMode(mode, alphamode)
end

-- canvas	(Canvas)	A render target.
-- 
function love.graphics.setCanvas(canvas)
end

-- 
function love.graphics.setCanvas()
end

-- canvas1	(Canvas)	The first render target.
-- canvas2	(Canvas)	The second render target.
-- ...	(Canvas)	More canvases.
-- 
function love.graphics.setCanvas(canvas1, canvas2, ...)
end

-- red	(number)	The amount of red.
-- green	(number)	The amount of green.
-- blue	(number)	The amount of blue.
-- alpha	(number)	The amount of alpha. The alpha value will be applied to all subsequent draw operations, even the drawing of an image.
-- 
function love.graphics.setColor(red, green, blue, alpha)
end

-- rgba	(table)	A numerical indexed table with the red, green, blue and alpha values as numbers. The alpha is optional and defaults to 255 if it is left out.
-- 
function love.graphics.setColor(rgba)
end

-- red	(boolean)	Render red component.
-- green	(boolean)	Render green component.
-- blue	(boolean)	Render blue component.
-- alpha	(boolean)	Render alpha component.
-- 
function love.graphics.setColorMask(red, green, blue, alpha)
end

-- 
function love.graphics.setColorMask()
end

-- min	(FilterMode)	Filter mode used when scaling the image down.
-- mag	(FilterMode)	Filter mode used when scaling the image up.
-- anisotropy	(number)	Maximum amount of Anisotropic Filtering used.
-- 
function love.graphics.setDefaultFilter(min, mag, anisotropy)
end

-- comparemode	(CompareMode)	Depth comparison mode used for depth testing.
-- write	(boolean)	Whether to write update / write values to the depth buffer when rendering.
-- 
function love.graphics.setDepthMode(comparemode, write)
end

-- font	(Font)	The Font object to use.
-- 
function love.graphics.setFont(font)
end

-- winding	(VertexWinding)	The winding mode to use. The default winding is counterclockwise ("ccw").
-- 
function love.graphics.setFrontFaceWinding(winding)
end

-- join	(LineJoin)	The LineJoin to use.
-- 
function love.graphics.setLineJoin(join)
end

-- style	(LineStyle)	The LineStyle to use.
-- 
function love.graphics.setLineStyle(style)
end

-- width	(number)	The width of the line.
-- 
function love.graphics.setLineWidth(width)
end

-- mode	(CullMode)	The Mesh face culling mode to use (whether to render everything, cull back-facing triangles, or cull front-facing triangles).
-- 
function love.graphics.setMeshCullMode(mode)
end

-- filename	(string)	The path and name of the file with the font.
-- size	(number)	The size of the font.
-- 
-- returns: font	(Font)	The new font.
function love.graphics.setNewFont(filename, size)
end

-- file	(File)	A File with the font.
-- size	(number)	The size of the font.
-- 
-- returns: font	(Font)	The new font.
function love.graphics.setNewFont(file, size)
end

-- data	(Data)	A Data with the font.
-- size	(number)	The size of the font.
-- 
-- returns: font	(Font)	The new font.
function love.graphics.setNewFont(data, size)
end

-- 
function love.graphics.setShader()
end

-- shader	(Shader)	The new shader.
-- 
function love.graphics.setShader(shader)
end

-- size	(number)	The new point size.
-- 
function love.graphics.setPointSize(size)
end

-- x	(number)	The X coordinate of upper left corner.
-- y	(number)	The Y coordinate of upper left corner.
-- width	(number)	The width of clipping rectangle.
-- height	(number)	The height of clipping rectangle.
-- 
function love.graphics.setScissor(x, y, width, height)
end

-- 
function love.graphics.setScissor()
end

-- comparemode	(CompareMode)	The type of comparison to make for each pixel.
-- comparevalue	(number)	The value to use when comparing with the stencil value of each pixel. Must be between 0 and 255.
-- 
function love.graphics.setStencilTest(comparemode, comparevalue)
end

-- 
function love.graphics.setStencilTest()
end

-- enable	(boolean)	True to enable wireframe mode when drawing, false to disable it.
-- 
function love.graphics.setWireframe(enable)
end

-- kx	(number)	The shear factor on the x-axis.
-- ky	(number)	The shear factor on the y-axis.
-- 
function love.graphics.shear(kx, ky)
end

-- stencilfunction	(function)	Function which draws geometry. The stencil values of pixels, rather than the color of each pixel, will be affected by the geometry.
-- action	(StencilAction)	How to modify any stencil values of pixels that are touched by what's drawn in the stencil function.
-- value	(number)	The new stencil value to use for pixels if the "replace" stencil action is used. Has no effect with other stencil actions. Must be between 0 and 255.
-- keepvalues	(boolean)	True to preserve old stencil values of pixels, false to re-set every pixel's stencil value to 0 before executing the stencil function. love.graphics.clear will also re-set all stencil values.
-- 
function love.graphics.stencil(stencilfunction, action, value, keepvalues)
end

-- globalX	(number)	The x component of the position in global coordinates.
-- globalY	(number)	The y component of the position in global coordinates.
-- 
-- returns: screenX	(number)	The x component of the position with graphics transformations applied.
-- returns: sreenY	(number)	The y component of the position with graphics transformations applied.
function love.graphics.transformPoint(globalX, globalY)
end

-- dx	(number)	The translation relative to the x-axis.
-- dy	(number)	The translation relative to the y-axis.
-- 
function love.graphics.translate(dx, dy)
end

-- gles	(boolean)	Validate code as GLSL ES shader.
-- code	(string)	The pixel shader or vertex shader code, or a filename pointing to a file with the code.
-- 
-- returns: status	(boolean)	true if specified shader code doesn't contain any errors. false otherwise.
-- returns: message	(string)	Reason why shader code validation failed (or nil if validation succeded).
function love.graphics.validateShader(gles, code)
end

-- gles	(boolean)	Validate code as GLSL ES shader.
-- pixelcode	(string)	The pixel shader code, or a filename pointing to a file with the code.
-- vertexcode	(string)	The vertex shader code, or a filename pointing to a file with the code.
-- 
-- returns: status	(boolean)	true if specified shader code doesn't contain any errors. false otherwise.
-- returns: message	(string)	Reason why shader code validation failed (or nil if validation succeded).
function love.graphics.validateShader(gles, pixelcode, vertexcode)
end
local image = {} -- {{{2

-- filename	(string)	The filename of the potentially compressed image file.
-- 
-- returns: compressed	(boolean)	Whether the file can be loaded as CompressedImageData or not.
function love.image.isCompressed(filename)
end

-- fileData	(FileData)	A FileData potentially containing a compressed image.
-- 
-- returns: compressed	(boolean)	Whether the FileData can be loaded as CompressedImageData or not.
function love.image.isCompressed(fileData)
end

-- filename	(string)	The filename of the compressed image file.
-- 
-- returns: compressedImageData	(CompressedImageData)	The new CompressedImageData object.
function love.image.newCompressedData(filename)
end

-- fileData	(FileData)	A FileData containing a compressed image.
-- 
-- returns: compressedImageData	(CompressedImageData)	The new CompressedImageData object.
function love.image.newCompressedData(fileData)
end

-- width	(number)	The width of the ImageData.
-- height	(number)	The height of the ImageData.
-- 
-- returns: imageData	(ImageData)	The new blank ImageData object. Each pixel's color values, (including the alpha values!) will be set to zero.
function love.image.newImageData(width, height)
end

-- width	(number)	The width of the ImageData.
-- height	(number)	The height of the ImageData.
-- data	(string)	The data to load into the ImageData (RGBA bytes, left to right and top to bottom).
-- 
-- returns: imageData	(ImageData)	The new ImageData object.
function love.image.newImageData(width, height, data)
end

-- filename	(string)	The filename of the image file.
-- 
-- returns: imageData	(ImageData)	The new ImageData object.
function love.image.newImageData(filename)
end

-- filedata	(FileData)	The encoded file data to decode into image data.
-- 
-- returns: imageData	(ImageData)	The new ImageData object.
function love.image.newImageData(filedata)
end
local joystick = {} -- {{{2

-- 
-- returns: joystickcount	(number)	The number of connected joysticks.
function love.joystick.getJoystickCount()
end

-- 
-- returns: joysticks	(table)	The list of currently connected Joysticks.
function love.joystick.getJoysticks()
end

-- filename	(string)	The filename to load the mappings string from.
-- 
function love.joystick.loadGamepadMappings(filename)
end

-- mappings	(string)	The mappings string to load.
-- 
function love.joystick.loadGamepadMappings(mappings)
end

-- filename	(string)	The filename to save the mappings string to.
-- 
-- returns: mappings	(string)	The mappings string that was written to the file.
function love.joystick.saveGamepadMappings(filename)
end

-- 
-- returns: mappings	(string)	The mappings string.
function love.joystick.saveGamepadMappings()
end

-- guid	(string)	The OS-dependent GUID for the type of Joystick the binding will affect.
-- button	(GamepadButton)	The virtual gamepad button to bind.
-- inputtype	(JoystickInputType)	The type of input to bind the virtual gamepad button to.
-- inputindex	(number)	The index of the axis, button, or hat to bind the virtual gamepad button to.
-- hatdirection	(JoystickHat)	The direction of the hat, if the virtual gamepad button will be bound to a hat. nil otherwise.
-- 
-- returns: success	(boolean)	Whether the virtual gamepad button was successfully bound.
function love.joystick.setGamepadMapping(guid, button, inputtype, inputindex, hatdirection)
end

-- guid	(string)	The OS-dependent GUID for the type of Joystick the binding will affect.
-- axis	(GamepadAxis)	The virtual gamepad axis to bind.
-- inputtype	(JoystickInputType)	The type of input to bind the virtual gamepad axis to.
-- inputindex	(number)	The index of the axis, button, or hat to bind the virtual gamepad axis to.
-- hatdirection	(JoystickHat)	The direction of the hat, if the virtual gamepad axis will be bound to a hat. nil otherwise.
-- 
-- returns: success	(boolean)	Whether the virtual gamepad button was successfully bound.
function love.joystick.setGamepadMapping(guid, axis, inputtype, inputindex, hatdirection)
end
local keyboard = {} -- {{{2

-- scancode	(Scancode)	The scancode to get the key from.
-- 
-- returns: key	(KeyConstant)	The key corresponding to the given scancode, or "unknown" if the scancode doesn't map to a KeyConstant on the current system.
function love.keyboard.getKeyFromScancode(scancode)
end

-- key	(KeyConstant)	The key to get the scancode from.
-- 
-- returns: scancode	(Scancode)	The scancode corresponding to the given key, or "unknown" if the given key has no known physical representation on the current system.
function love.keyboard.getScancodeFromKey(key)
end

-- 
-- returns: enabled	(boolean)	Whether key repeat is enabled.
function love.keyboard.hasKeyRepeat()
end

-- 
-- returns: enabled	(boolean)	Whether text input events are enabled.
function love.keyboard.hasTextInput()
end

-- key	(KeyConstant)	The key to check.
-- 
-- returns: down	(boolean)	True if the key is down, false if not.
function love.keyboard.isDown(key)
end

-- key	(KeyConstant)	A key to check.
-- ...	(KeyConstant)	Additional keys to check.
-- 
-- returns: anyDown	(boolean)	True if any supplied key is down, false if not.
function love.keyboard.isDown(key, ...)
end

-- scancode	(Scancode)	A Scancode to check.
-- ...	(Scancode)	Additional Scancodes to check.
-- 
-- returns: down	(boolean)	True if any supplied Scancode is down, false if not.
function love.keyboard.isScancodeDown(scancode, ...)
end

-- enable	(boolean)	Whether repeat keypress events should be enabled when a key is held down.
-- 
function love.keyboard.setKeyRepeat(enable)
end

-- enable	(boolean)	Whether text input events should be enabled.
-- 
function love.keyboard.setTextInput(enable)
end

-- enable	(boolean)	Whether text input events should be enabled.
-- x	(number)	On-screen keyboard x position.
-- y	(number)	On-screen keyboard y position.
-- w	(number)	On-screen keyboard width.
-- h	(number)	On-screen keyboard height.
-- 
function love.keyboard.setTextInput(enable, x, y, w, h)
end
local math = {} -- {{{2

-- rawstring	(string)	The raw (un-compressed) string to compress.
-- format	(CompressedDataFormat)	The format to use when compressing the string.
-- level	(number)	The level of compression to use, between 0 and 9. -1 indicates the default level. The meaning of this argument depends on the compression format being used.
-- 
-- returns: compressedData	(CompressedData)	A new Data object containing the compressed version of the string.
function love.math.compress(rawstring, format, level)
end

-- data	(Data)	A Data object containing the raw (un-compressed) data to compress.
-- format	(CompressedDataFormat)	The format to use when compressing the data.
-- level	(number)	The level of compression to use, between 0 and 9. -1 indicates the default level. The meaning of this argument depends on the compression format being used.
-- 
-- returns: compressedData	(CompressedData)	A new Data object containing the compressed version of the raw data.
function love.math.compress(data, format, level)
end

-- compressedData	(CompressedData)	The compressed data to decompress.
-- 
-- returns: rawstring	(string)	A string containing the raw decompressed data.
function love.math.decompress(compressedData)
end

-- compressedString	(string)	A string containing data previously compressed with love.math.compress.
-- format	(CompressedDataFormat)	The format that was used to compress the given string.
-- 
-- returns: rawstring	(string)	A string containing the raw decompressed data.
function love.math.decompress(compressedString, format)
end

-- data	(Data)	A Data object containing data previously compressed with love.math.compress.
-- format	(CompressedDataFormat)	The format that was used to compress the given data.
-- 
-- returns: rawstring	(string)	A string containing the raw decompressed data.
function love.math.decompress(data, format)
end

-- r	(number)	The red channel of the sRGB color to convert.
-- g	(number)	The green channel of the sRGB color to convert.
-- b	(number)	The blue channel of the sRGB color to convert.
-- 
-- returns: lr	(number)	The red channel of the converted color in linear RGB space.
-- returns: lg	(number)	The green channel of the converted color in linear RGB space.
-- returns: lb	(number)	The blue channel of the converted color in linear RGB space.
function love.math.gammaToLinear(r, g, b)
end

-- color	(table)	An array with the red, green, and blue channels of the sRGB color to convert.
-- 
-- returns: lr	(number)	The red channel of the converted color in linear RGB space.
-- returns: lg	(number)	The green channel of the converted color in linear RGB space.
-- returns: lb	(number)	The blue channel of the converted color in linear RGB space.
function love.math.gammaToLinear(color)
end

-- c	(number)	The value of a color channel in sRGB space to convert.
-- 
-- returns: lc	(number)	The value of the color channel in linear RGB space.
function love.math.gammaToLinear(c)
end

-- 
-- returns: low	(number)	Integer number representing the lower 32 bits of the random number generator's 64 bit state value.
-- returns: high	(number)	Integer number representing the higher 32 bits of the random number generator's 64 bit state value.
function love.math.getRandomSeed()
end

-- 
-- returns: state	(string)	The current state of the RandomGenerator object, represented as a string.
function love.math.getRandomState()
end

-- vertices	(table)	The vertices of the polygon as a table in the form of {x1, y1, x2, y2, x3, y3, ...}.
-- 
-- returns: convex	(boolean)	Whether the given polygon is convex.
function love.math.isConvex(vertices)
end

-- x1	(number)	The position of the first vertex of the polygon on the x-axis.
-- y1	(number)	The position of the first vertex of the polygon on the y-axis.
-- x2	(number)	The position of the second vertex of the polygon on the x-axis.
-- y2	(number)	The position of the second vertex of the polygon on the y-axis.
-- x3	(number)	The position of the third vertex of the polygon on the x-axis.
-- y3	(number)	The position of the third vertex of the polygon on the y-axis.
-- ...	(number)	Additional vertices.
-- 
-- returns: convex	(boolean)	Whether the given polygon is convex.
function love.math.isConvex(x1, y1, x2, y2, x3, y3, ...)
end

-- lr	(number)	The red channel of the linear RGB color to convert.
-- lg	(number)	The green channel of the linear RGB color to convert.
-- lb	(number)	The blue channel of the linear RGB color to convert.
-- 
-- returns: cr	(number)	The red channel of the converted color in gamma sRGB space.
-- returns: cg	(number)	The green channel of the converted color in gamma sRGB space.
-- returns: cb	(number)	The blue channel of the converted color in gamma sRGB space.
function love.math.linearToGamma(lr, lg, lb)
end

-- color	(table)	An array with the red, green, and blue channels of the linear RGB color to convert.
-- 
-- returns: cr	(number)	The red channel of the converted color in gamma sRGB space.
-- returns: cg	(number)	The green channel of the converted color in gamma sRGB space.
-- returns: cb	(number)	The blue channel of the converted color in gamma sRGB space.
function love.math.linearToGamma(color)
end

-- lc	(number)	The value of a color channel in linear RGB space to convert.
-- 
-- returns: c	(number)	The value of the color channel in gamma sRGB space.
function love.math.linearToGamma(lc)
end

-- vertices	(table)	The vertices of the control polygon as a table in the form of {x1, y1, x2, y2, x3, y3, ...}.
-- 
-- returns: curve	(BezierCurve)	A Bézier curve object.
function love.math.newBezierCurve(vertices)
end

-- x1	(number)	The position of the first vertex of the control polygon on the x-axis.
-- y1	(number)	The position of the first vertex of the control polygon on the y-axis.
-- x2	(number)	The position of the second vertex of the control polygon on the x-axis.
-- y2	(number)	The position of the second vertex of the control polygon on the y-axis.
-- x3	(number)	The position of the third vertex of the control polygon on the x-axis.
-- y3	(number)	The position of the third vertex of the control polygon on the y-axis.
-- ...	(number)	Additional vertices.
-- 
-- returns: curve	(BezierCurve)	A Bézier curve object.
function love.math.newBezierCurve(x1, y1, x2, y2, x3, y3, ...)
end

-- 
-- returns: rng	(RandomGenerator)	The new Random Number Generator object.
function love.math.newRandomGenerator()
end

-- seed	(number)	The initial seed number to use for this object.
-- 
-- returns: rng	(RandomGenerator)	The new Random Number Generator object.
function love.math.newRandomGenerator(seed)
end

-- low	(number)	The lower 32 bits of the state number to use for this instance of the object.
-- high	(number)	The higher 32 bits of the state number to use for this instance of the object.
-- 
-- returns: rng	(RandomGenerator)	The new Random Number Generator object.
function love.math.newRandomGenerator(low, high)
end

-- 
-- returns: transform	(Transform)	The new Transform object.
function love.math.newTransform()
end

-- x	(number)	The position of the new Transform on the x-axis.
-- y	(number)	The position of the new Transform on the y-axis.
-- angle	(number)	The orientation of the new Transform in radians.
-- sx	(number)	Scale factor on the x-axis.
-- sy	(number)	Scale factor on the y-axis.
-- ox	(number)	Origin offset on the x-axis.
-- oy	(number)	Origin offset on the y-axis.
-- kx	(number)	Shearing / skew factor on the x-axis.
-- ky	(number)	Shearing / skew factor on the y-axis.
-- 
-- returns: transform	(Transform)	The new Transform object.
function love.math.newTransform(x, y, angle, sx, sy, ox, oy, kx, ky)
end

-- x	(number)	The number used to generate the noise value.
-- 
-- returns: value	(number)	The noise value in the range of [0, 1].
function love.math.noise(x)
end

-- x	(number)	The first value of the 2-dimensional vector used to generate the noise value.
-- y	(number)	The second value of the 2-dimensional vector used to generate the noise value.
-- 
-- returns: value	(number)	The noise value in the range of [0, 1].
function love.math.noise(x, y)
end

-- x	(number)	The first value of the 3-dimensional vector used to generate the noise value.
-- y	(number)	The second value of the 3-dimensional vector used to generate the noise value.
-- z	(number)	The third value of the 3-dimensional vector used to generate the noise value.
-- 
-- returns: value	(number)	The noise value in the range of [0, 1].
function love.math.noise(x, y, z)
end

-- x	(number)	The first value of the 4-dimensional vector used to generate the noise value.
-- y	(number)	The second value of the 4-dimensional vector used to generate the noise value.
-- z	(number)	The third value of the 4-dimensional vector used to generate the noise value.
-- w	(number)	The fourth value of the 4-dimensional vector used to generate the noise value.
-- 
-- returns: value	(number)	The noise value in the range of [0, 1].
function love.math.noise(x, y, z, w)
end

-- 
-- returns: number	(number)	The pseudo-random number.
function love.math.random()
end

-- max	(number)	The maximum possible value it should return.
-- 
-- returns: number	(number)	The pseudo-random integer number.
function love.math.random(max)
end

-- min	(number)	The minimum possible value it should return.
-- max	(number)	The maximum possible value it should return.
-- 
-- returns: number	(number)	The pseudo-random integer number.
function love.math.random(min, max)
end

-- stddev	(number)	Standard deviation of the distribution.
-- mean	(number)	The mean of the distribution.
-- 
-- returns: number	(number)	Normally distributed random number with variance (stddev)² and the specified mean.
function love.math.randomNormal(stddev, mean)
end

-- seed	(number)	The integer number with which you want to seed the randomization. Must be within the range of [1, 2^53].
-- 
function love.math.setRandomSeed(seed)
end

-- low	(number)	The lower 32 bits of the state value. Must be within the range of [0, 2^32 - 1].
-- high	(number)	The higher 32 bits of the state value. Must be within the range of [0, 2^32 - 1].
-- 
function love.math.setRandomSeed(low, high)
end

-- state	(string)	The current state of the RandomGenerator object, represented as a string.
-- 
function love.math.setRandomState(state)
end

-- polygon	(table)	Polygon to triangulate. Must not intersect itself.
-- 
-- returns: triangles	(table)	List of triangles the polygon is composed of, in the form of {{x1, y1, x2, y2, x3, y3}, {x1, y1, x2, y2, x3, y3}, ...}.
function love.math.triangulate(polygon)
end

-- x1	(number)	The position of the first vertex of the polygon on the x-axis.
-- y1	(number)	The position of the first vertex of the polygon on the y-axis.
-- x2	(number)	The position of the second vertex of the polygon on the x-axis.
-- y2	(number)	The position of the second vertex of the polygon on the y-axis.
-- x3	(number)	The position of the third vertex of the polygon on the x-axis.
-- y3	(number)	The position of the third vertex of the polygon on the y-axis.
-- ...	(number)	Additional vertices.
-- 
-- returns: triangles	(table)	List of triangles the polygon is composed of, in the form of {{x1, y1, x2, y2, x3, y3}, {x1, y1, x2, y2, x3, y3}, ...}.
function love.math.triangulate(x1, y1, x2, y2, x3, y3, ...)
end
local mouse = {} -- {{{2

-- 
-- returns: cursor	(Cursor)	The current cursor, or nil if no cursor is set.
function love.mouse.getCursor()
end

-- 
-- returns: x	(number)	The position of the mouse along the x-axis.
-- returns: y	(number)	The position of the mouse along the y-axis.
function love.mouse.getPosition()
end

-- 
-- returns: enabled	(boolean)	True if relative mode is enabled, false if it's disabled.
function love.mouse.getRelativeMode()
end

-- ctype	(CursorType)	The type of system cursor to get.
-- 
-- returns: cursor	(Cursor)	The Cursor object representing the system cursor type.
function love.mouse.getSystemCursor(ctype)
end

-- 
-- returns: x	(number)	The position of the mouse along the x-axis.
function love.mouse.getX()
end

-- 
-- returns: y	(number)	The position of the mouse along the y-axis.
function love.mouse.getY()
end

-- 
-- returns: hascursor	(boolean)	Whether the system has cursor functionality.
function love.mouse.hasCursor()
end

-- 
-- returns: supported	(boolean)	Whether the system has cursor functionality.
function love.mouse.isCursorSupported()
end

-- button	(number)	The index of a button to check. 1 is the primary mouse button, 2 is the secondary mouse button, etc.
-- ...	(number)	Additional button numbers to check.
-- 
-- returns: down	(boolean)	True if the specified button is down.
function love.mouse.isDown(button, ...)
end

-- 
-- returns: grabbed	(boolean)	True if the cursor is grabbed, false if it is not.
function love.mouse.isGrabbed()
end

-- 
-- returns: visible	(boolean)	True if the cursor to visible, false if the cursor is hidden.
function love.mouse.isVisible()
end

-- imageData	(ImageData)	The ImageData to use for the the new Cursor.
-- hotx	(number)	The x-coordinate in the ImageData of the cursor's hot spot.
-- hoty	(number)	The y-coordinate in the ImageData of the cursor's hot spot.
-- 
-- returns: cursor	(Cursor)	The new Cursor object.
function love.mouse.newCursor(imageData, hotx, hoty)
end

-- filepath	(string)	Path to the image to use for the new Cursor.
-- hotx	(number)	The x-coordinate in the ImageData of the cursor's hot spot.
-- hoty	(number)	The y-coordinate in the ImageData of the cursor's hot spot.
-- 
-- returns: cursor	(Cursor)	The new Cursor object.
function love.mouse.newCursor(filepath, hotx, hoty)
end

-- fileData	(FileData)	Data representing the image to use for the new Cursor.
-- hotx	(number)	The x-coordinate in the ImageData of the cursor's hot spot.
-- hoty	(number)	The y-coordinate in the ImageData of the cursor's hot spot.
-- 
-- returns: cursor	(Cursor)	The new Cursor object.
function love.mouse.newCursor(fileData, hotx, hoty)
end

-- 
function love.mouse.setCursor()
end

-- cursor	(Cursor)	The Cursor object to use as the current mouse cursor.
-- 
function love.mouse.setCursor(cursor)
end

-- grab	(boolean)	True to confine the mouse, false to let it leave the window.
-- 
function love.mouse.setGrabbed(grab)
end

-- x	(number)	The new position of the mouse along the x-axis.
-- y	(number)	The new position of the mouse along the y-axis.
-- 
function love.mouse.setPosition(x, y)
end

-- enable	(boolean)	True to enable relative mode, false to disable it.
-- 
function love.mouse.setRelativeMode(enable)
end

-- visible	(boolean)	True to set the cursor to visible, false to hide the cursor.
-- 
function love.mouse.setVisible(visible)
end

-- x	(number)	The new position of the mouse along the x-axis.
-- 
function love.mouse.setX(x)
end

-- y	(number)	The new position of the mouse along the y-axis.
-- 
function love.mouse.setY(y)
end
local physics = {} -- {{{2

-- fixture1	(Fixture)	The first fixture.
-- fixture2	(Fixture)	The second fixture.
-- 
-- returns: distance	(number)	The distance of the two points.
-- returns: x1	(number)	The x-coordinate of the first point.
-- returns: y1	(number)	The y-coordinate of the first point.
-- returns: x2	(number)	The x-coordinate of the second point.
-- returns: y2	(number)	The y-coordinate of the second point.
function love.physics.getDistance(fixture1, fixture2)
end

-- 
-- returns: scale	(number)	The size of 1 meter in pixels.
function love.physics.getMeter()
end

-- world	(World)	The world to create the body in.
-- x	(number)	The x position of the body.
-- y	(number)	The y position of the body.
-- type	(BodyType)	The type of the body.
-- 
-- returns: body	(Body)	A new body.
function love.physics.newBody(world, x, y, type)
end

-- loop	(boolean)	If the chain should loop back to the first point.
-- x1	(number)	The x position of the first point.
-- y1	(number)	The y position of the first point.
-- x2	(number)	The x position of the second point.
-- y2	(number)	The y position of the second point.
-- ...	(number)	Additional point positions.
-- 
-- returns: shape	(ChainShape)	The new shape.
function love.physics.newChainShape(loop, x1, y1, x2, y2, ...)
end

-- loop	(boolean)	If the chain should loop back to the first point.
-- points	(table)	A list of points to construct the ChainShape, in the form of {x1, y1, x2, y2, ...}.
-- 
-- returns: shape	(ChainShape)	The new shape.
function love.physics.newChainShape(loop, points)
end

-- radius	(number)	The radius of the circle.
-- 
-- returns: shape	(CircleShape)	The new shape.
function love.physics.newCircleShape(radius)
end

-- x	(number)	The x offset of the circle.
-- y	(number)	The y offset of the circle.
-- radius	(number)	The radius of the circle.
-- 
-- returns: shape	(CircleShape)	The new shape.
function love.physics.newCircleShape(x, y, radius)
end

-- body1	(Body)	The first body to attach to the joint.
-- body2	(Body)	The second body to attach to the joint.
-- x1	(number)	The x position of the first anchor point (world space).
-- y1	(number)	The y position of the first anchor point (world space).
-- x2	(number)	The x position of the second anchor point (world space).
-- y2	(number)	The y position of the second anchor point (world space).
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(DistanceJoint)	The new distance joint.
function love.physics.newDistanceJoint(body1, body2, x1, y1, x2, y2, collideConnected)
end

-- x1	(number)	The x position of the first point.
-- y1	(number)	The y position of the first point.
-- x2	(number)	The x position of the second point.
-- y2	(number)	The y position of the second point.
-- 
-- returns: shape	(EdgeShape)	The new shape.
function love.physics.newEdgeShape(x1, y1, x2, y2)
end

-- body	(Body)	The body which gets the fixture attached.
-- shape	(Shape)	The shape of the fixture.
-- density	(number)	The density of the fixture.
-- 
-- returns: fixture	(Fixture)	The new fixture.
function love.physics.newFixture(body, shape, density)
end

-- body1	(Body)	The first body to attach to the joint.
-- body2	(Body)	The second body to attach to the joint.
-- x	(number)	The x position of the anchor point.
-- y	(number)	The y position of the anchor point.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with eachother.
-- 
-- returns: joint	(FrictionJoint)	The new FrictionJoint.
function love.physics.newFrictionJoint(body1, body2, x, y, collideConnected)
end

-- joint1	(Joint)	The first joint to connect with a gear joint.
-- joint2	(Joint)	The second joint to connect with a gear joint.
-- ratio	(number)	The gear ratio.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(GearJoint)	The new gear joint.
function love.physics.newGearJoint(joint1, joint2, ratio, collideConnected)
end

-- body1	(Body)	The first body to attach to the joint.
-- body2	(Body)	The second body to attach to the joint.
-- correctionFactor	(number)	The joint's initial position correction factor, in the range of [0, 1].
-- 
-- returns: joint	(MotorJoint)	The new MotorJoint.
function love.physics.newMotorJoint(body1, body2, correctionFactor)
end

-- body1	(Body)	The first body to attach to the joint.
-- body2	(Body)	The second body to attach to the joint.
-- correctionFactor	(number)	The joint's initial position correction factor, in the range of [0, 1].
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(MotorJoint)	The new MotorJoint.
function love.physics.newMotorJoint(body1, body2, correctionFactor, collideConnected)
end

-- body	(Body)	The body to attach to the mouse.
-- x	(number)	The x position of the connecting point.
-- y	(number)	The y position of the connecting point.
-- 
-- returns: joint	(MouseJoint)	The new mouse joint.
function love.physics.newMouseJoint(body, x, y)
end

-- x1	(number)	The position of first point on the x-axis.
-- y1	(number)	The position of first point on the y-axis.
-- x2	(number)	The position of second point on the x-axis.
-- y2	(number)	The position of second point on the y-axis.
-- ...	(number)	You can continue passing more point positions to create the PolygonShape.
-- 
-- returns: shape	(PolygonShape)	A new PolygonShape.
function love.physics.newPolygonShape(x1, y1, x2, y2, ...)
end

-- vertices	(table)	A list of vertices to construct the polygon, in the form of {x1, y1, x2, y2, x3, y3, ...}.
-- 
-- returns: shape	(PolygonShape)	A new PolygonShape.
function love.physics.newPolygonShape(vertices)
end

-- body1	(Body)	The first body to connect with a prismatic joint.
-- body2	(Body)	The second body to connect with a prismatic joint.
-- x	(number)	The x coordinate of the anchor point.
-- y	(number)	The y coordinate of the anchor point.
-- ax	(number)	The x coordinate of the axis unit vector.
-- ay	(number)	The y coordinate of the axis unit vector.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(PrismaticJoint)	The new prismatic joint.
function love.physics.newPrismaticJoint(body1, body2, x, y, ax, ay, collideConnected)
end

-- body1	(Body)	The first body to connect with a prismatic joint.
-- body2	(Body)	The second body to connect with a prismatic joint.
-- x1	(number)	The x coordinate of the first anchor point.
-- y1	(number)	The y coordinate of the first anchor point.
-- x2	(number)	The x coordinate of the second anchor point.
-- y2	(number)	The y coordinate of the second anchor point.
-- ax	(number)	The x coordinate of the axis unit vector.
-- ay	(number)	The y coordinate of the axis unit vector.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(PrismaticJoint)	The new prismatic joint.
function love.physics.newPrismaticJoint(body1, body2, x1, y1, x2, y2, ax, ay, collideConnected)
end

-- body1	(Body)	The first body to connect with a prismatic joint.
-- body2	(Body)	The second body to connect with a prismatic joint.
-- x1	(number)	The x coordinate of the first anchor point.
-- y1	(number)	The y coordinate of the first anchor point.
-- x2	(number)	The x coordinate of the second anchor point.
-- y2	(number)	The y coordinate of the second anchor point.
-- ax	(number)	The x coordinate of the axis unit vector.
-- ay	(number)	The y coordinate of the axis unit vector.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- referenceAngle	(number)	The reference angle between body1 and body2, in radians.
-- 
-- returns: joint	(PrismaticJoint)	The new prismatic joint.
function love.physics.newPrismaticJoint(body1, body2, x1, y1, x2, y2, ax, ay, collideConnected, referenceAngle)
end

-- body1	(Body)	The first body to connect with a pulley joint.
-- body2	(Body)	The second body to connect with a pulley joint.
-- gx1	(number)	The x coordinate of the first body's ground anchor.
-- gy1	(number)	The y coordinate of the first body's ground anchor.
-- gx2	(number)	The x coordinate of the second body's ground anchor.
-- gy2	(number)	The y coordinate of the second body's ground anchor.
-- x1	(number)	The x coordinate of the pulley joint anchor in the first body.
-- y1	(number)	The y coordinate of the pulley joint anchor in the first body.
-- x2	(number)	The x coordinate of the pulley joint anchor in the second body.
-- y2	(number)	The y coordinate of the pulley joint anchor in the second body.
-- ratio	(number)	The joint ratio.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(PulleyJoint)	The new pulley joint.
function love.physics.newPulleyJoint(body1, body2, gx1, gy1, gx2, gy2, x1, y1, x2, y2, ratio, collideConnected)
end

-- width	(number)	The width of the rectangle.
-- height	(number)	The height of the rectangle.
-- 
-- returns: shape	(PolygonShape)	A new PolygonShape.
function love.physics.newRectangleShape(width, height)
end

-- x	(number)	The offset along the x-axis.
-- y	(number)	The offset along the y-axis.
-- width	(number)	The width of the rectangle.
-- height	(number)	The height of the rectangle.
-- angle	(number)	The initial angle of the rectangle.
-- 
-- returns: shape	(PolygonShape)	A new PolygonShape.
function love.physics.newRectangleShape(x, y, width, height, angle)
end

-- body1	(Body)	The first body.
-- body2	(Body)	The second body.
-- x	(number)	The x position of the connecting point.
-- y	(number)	The y position of the connecting point.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(RevoluteJoint)	The new revolute joint.
function love.physics.newRevoluteJoint(body1, body2, x, y, collideConnected)
end

-- body1	(Body)	The first body.
-- body2	(Body)	The second body.
-- x1	(number)	The x position of the first connecting point.
-- y1	(number)	The y position of the first connecting point.
-- x2	(number)	The x position of the second connecting point.
-- y2	(number)	The y position of the second connecting point.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- referenceAngle	(number)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(RevoluteJoint)	The new revolute joint.
function love.physics.newRevoluteJoint(body1, body2, x1, y1, x2, y2, collideConnected, referenceAngle)
end

-- body1	(Body)	The first body to attach to the joint.
-- body2	(Body)	The second body to attach to the joint.
-- x1	(number)	The x position of the first anchor point.
-- y1	(number)	The y position of the first anchor point.
-- x2	(number)	The x position of the second anchor point.
-- y2	(number)	The y position of the second anchor point.
-- maxLength	(number)	The maximum distance for the bodies.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(RopeJoint)	The new RopeJoint.
function love.physics.newRopeJoint(body1, body2, x1, y1, x2, y2, maxLength, collideConnected)
end

-- body1	(Body)	The first body to attach to the joint.
-- body2	(Body)	The second body to attach to the joint.
-- x	(number)	The x position of the anchor point (world space).
-- y	(number)	The y position of the anchor point (world space).
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(WeldJoint)	The new WeldJoint.
function love.physics.newWeldJoint(body1, body2, x, y, collideConnected)
end

-- body1	(Body)	The first body to attach to the joint.
-- body2	(Body)	The second body to attach to the joint.
-- x1	(number)	The x position of the first anchor point (world space).
-- y1	(number)	The y position of the first anchor point (world space).
-- x2	(number)	The x position of the second anchor point (world space).
-- y2	(number)	The y position of the second anchor point (world space).
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(WeldJoint)	The new WeldJoint.
function love.physics.newWeldJoint(body1, body2, x1, y1, x2, y2, collideConnected)
end

-- body1	(Body)	The first body to attach to the joint.
-- body2	(Body)	The second body to attach to the joint.
-- x1	(number)	The x position of the first anchor point (world space).
-- y1	(number)	The y position of the first anchor point (world space).
-- x2	(number)	The x position of the second anchor point (world space).
-- y2	(number)	The y position of the second anchor point (world space).
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- referenceAngle	(number)	The reference angle between body1 and body2, in radians.
-- 
-- returns: joint	(WeldJoint)	The new WeldJoint.
function love.physics.newWeldJoint(body1, body2, x1, y1, x2, y2, collideConnected, referenceAngle)
end

-- body1	(Body)	The first body.
-- body2	(Body)	The second body.
-- x	(number)	The x position of the anchor point.
-- y	(number)	The y position of the anchor point.
-- ax	(number)	The x position of the axis unit vector.
-- ay	(number)	The y position of the axis unit vector.
-- collideConnected	(boolean)	Specifies whether the two bodies should collide with each other.
-- 
-- returns: joint	(WheelJoint)	The new WheelJoint.
function love.physics.newWheelJoint(body1, body2, x, y, ax, ay, collideConnected)
end

-- xg	(number)	The x component of gravity.
-- yg	(number)	The y component of gravity.
-- sleep	(boolean)	Whether the bodies in this world are allowed to sleep.
-- 
-- returns: world	(World)	A brave new World.
function love.physics.newWorld(xg, yg, sleep)
end

-- scale	(number)	The scale factor as an integer.
-- 
function love.physics.setMeter(scale)
end
local sound = {} -- {{{2

-- file	(File)	The file with encoded sound data.
-- buffer	(number)	The size of each decoded chunk, in bytes.
-- 
-- returns: decoder	(Decoder)	A new Decoder object.
function love.sound.newDecoder(file, buffer)
end

-- filename	(string)	The filename of the file with encoded sound data.
-- buffer	(number)	The size of each decoded chunk, in bytes.
-- 
-- returns: decoder	(Decoder)	A new Decoder object.
function love.sound.newDecoder(filename, buffer)
end

-- filename	(string)	The filename of the file to load.
-- 
-- returns: soundData	(SoundData)	A new SoundData object.
function love.sound.newSoundData(filename)
end

-- file	(File)	A File pointing to an audio file.
-- 
-- returns: soundData	(SoundData)	A new SoundData object.
function love.sound.newSoundData(file)
end

-- data	(Data)	The encoded data to decode into audio.
-- 
-- returns: soundData	(SoundData)	A new SoundData object.
function love.sound.newSoundData(data)
end

-- samples	(number)	Total number of samples.
-- rate	(number)	Number of samples per second
-- bits	(number)	Bits per sample (8 or 16).
-- channels	(number)	Either 1 for mono or 2 for stereo.
-- 
-- returns: soundData	(SoundData)	A new SoundData object.
function love.sound.newSoundData(samples, rate, bits, channels)
end
local system = {} -- {{{2

-- 
-- returns: text	(string)	The text currently held in the system's clipboard.
function love.system.getClipboardText()
end

-- 
-- returns: osString	(string)	The current operating system. "OS X", "Windows", "Linux", "Android" or "iOS".
function love.system.getOS()
end

-- 
-- returns: state	(PowerState)	The basic state of the power supply.
-- returns: percent	(number)	Percentage of battery life left, between 0 and 100. nil if the value can't be determined or there's no battery.
-- returns: seconds	(number)	Seconds of battery life left. nil if the value can't be determined or there's no battery.
function love.system.getPowerInfo()
end

-- 
-- returns: processorCount	(number)	Amount of logical processors.
function love.system.getProcessorCount()
end

-- url	(string)	The URL to open. Must be formatted as a proper URL.

To open a file or folder, "file://" must be prepended to the path.
-- 
-- returns: success	(boolean)	Whether the URL was opened successfully.
function love.system.openURL(url)
end

-- text	(string)	The new text to hold in the system's clipboard.
-- 
function love.system.setClipboardText(text)
end

-- seconds	(number)	The duration to vibrate for. If called on an iOS device, it will always vibrate for 0.5 seconds due to limitations in the iOS system APIs.
-- 
function love.system.vibrate(seconds)
end
local thread = {} -- {{{2

-- name	(string)	The name of the channel you want to create or retrieve.
-- 
-- returns: channel	(Channel)	A named channel object which can be further manipulated.
function love.thread.getChannel(name)
end

-- 
-- returns: channel	(Channel)	A unnamed channel object which can be further manipulated.
function love.thread.newChannel()
end

-- filename	(string)	The name of the Lua File to use as source.
-- 
-- returns: thread	(Thread)	A new Thread that has yet to be started.
function love.thread.newThread(filename)
end

-- fileData	(FileData)	The FileData containing the Lua code to use as the source.
-- 
-- returns: thread	(Thread)	A new Thread that has yet to be started.
function love.thread.newThread(fileData)
end

-- codestring	(string)	A string containing the Lua code to use as the source. It needs to either be at least 1024 characters long, or contain at least one newline.
-- 
-- returns: thread	(Thread)	A new Thread that has yet to be started.
function love.thread.newThread(codestring)
end
local timer = {} -- {{{2

-- 
-- returns: delta	(number)	The average delta time over the last second.
function love.timer.getAverageDelta()
end

-- 
-- returns: dt	(number)	The time passed (in seconds).
function love.timer.getDelta()
end

-- 
-- returns: fps	(number)	The current FPS.
function love.timer.getFPS()
end

-- 
-- returns: time	(number)	The time in seconds.
function love.timer.getTime()
end

-- s	(number)	Seconds to sleep for.
-- 
function love.timer.sleep(s)
end

-- 
function love.timer.step()
end

-- 
-- returns: dt	(number)	The time passed (in seconds).
function love.timer.step()
end
local touch = {} -- {{{2

-- id	(light userdata)	The identifier of the touch-press. Use love.touch.getTouches, love.touchpressed, or love.touchmoved to obtain touch id values.
-- 
-- returns: x	(number)	The position along the x-axis of the touch-press inside the window, in pixels.
-- returns: y	(number)	The position along the y-axis of the touch-press inside the window, in pixels.
function love.touch.getPosition(id)
end

-- id	(light userdata)	The identifier of the touch-press. Use love.touch.getTouches, love.touchpressed, or love.touchmoved to obtain touch id values.
-- 
-- returns: pressure	(number)	The pressure of the touch-press. Most touch screens aren't pressure sensitive, in which case the pressure will be 1.
function love.touch.getPressure(id)
end

-- 
-- returns: touches	(table)	A list of active touch-press id values, which can be used with love.touch.getPosition.
function love.touch.getTouches()
end
local video = {} -- {{{2

-- filename	(string)	The file path to the Ogg Theora video file.
-- 
-- returns: videostream	(VideoStream)	A new VideoStream.
function love.video.newVideoStream(filename)
end

-- file	(File)	The File object containing the Ogg Theora video.
-- 
-- returns: videostream	(VideoStream)	A new VideoStream.
function love.video.newVideoStream(file)
end
local window = {} -- {{{2

-- 
function love.window.close()
end

-- pixelvalue	(number)	A number in pixels to convert to density-independent units.
-- 
-- returns: value	(number)	The converted number, in density-independent units.
function love.window.fromPixels(pixelvalue)
end

-- px	(number)	The x-axis value of a coordinate in pixels.
-- py	(number)	The y-axis value of a coordinate in pixels.
-- 
-- returns: x	(number)	The converted x-axis value of the coordinate, in density-independent units.
-- returns: y	(number)	The converted y-axis value of the coordinate, in density-independent units.
function love.window.fromPixels(px, py)
end

-- displayindex	(number)	The index of the display to get the name of.
-- 
-- returns: name	(string)	The name of the specified display.
function love.window.getDisplayName(displayindex)
end

-- 
-- returns: scale	(number)	The pixel scale factor associated with the window.
function love.window.getDPIScale()
end

-- 
-- returns: fullscreen	(boolean)	True if the window is fullscreen, false otherwise.
-- returns: fstype	(FullscreenType)	The type of fullscreen mode used.
function love.window.getFullscreen()
end

-- display	(number)	The index of the display, if multiple monitors are available.
-- 
-- returns: modes	(table)	A table of width/height pairs. (Note that this may not be in order.)
function love.window.getFullscreenModes(display)
end

-- 
-- returns: imagedata	(ImageData)	The window icon imagedata, or nil of no icon has been set with love.window.setIcon.
function love.window.getIcon()
end

-- 
-- returns: width	(number)	Window width.
-- returns: height	(number)	Window height.
-- returns: flags	(table)	Table containing the window properties.
function love.window.getMode()
end

-- 
-- returns: scale	(number)	The pixel scale factor associated with the window.
function love.window.getPixelScale()
end

-- 
-- returns: x	(number)	The x-coordinate of the window's position.
-- returns: y	(number)	The y-coordinate of the window's position.
-- returns: display	(number)	The index of the display that the window is in.
function love.window.getPosition()
end

-- 
-- returns: title	(string)	The current window title.
function love.window.getTitle()
end

-- 
-- returns: focus	(boolean)	True if the window has the focus or false if not.
function love.window.hasFocus()
end

-- 
-- returns: focus	(boolean)	True if the window has mouse focus or false if not.
function love.window.hasMouseFocus()
end

-- 
-- returns: enabled	(boolean)	True if system display sleep is enabled / allowed, false otherwise.
function love.window.isDisplaySleepEnabled()
end

-- 
-- returns: maximized	(boolean)	True if the window is currently maximized in windowed mode, false otherwise.
function love.window.isMaximized()
end

-- 
-- returns: maximized	(boolean)	True if the window is currently minimized, false otherwise.
function love.window.isMinimized()
end

-- 
-- returns: open	(boolean)	True if the window is open, false otherwise.
function love.window.isOpen()
end

-- 
-- returns: visible	(boolean)	True if the window is visible or false if not.
function love.window.isVisible()
end

-- 
function love.window.maximize()
end

-- 
function love.window.minimize()
end

-- 
function love.window.restore()
end

-- continuous	(boolean)	Whether to continuously request attention until the window becomes active, or to do it only once.
-- 
function love.window.requestAttention(continuous)
end

-- enable	(boolean)	True to enable system display sleep, false to disable it.
-- 
function love.window.setDisplaySleepEnabled(enable)
end

-- fullscreen	(boolean)	Whether to enter or exit fullscreen mode.
-- 
-- returns: success	(boolean)	True if successful, false otherwise.
function love.window.setFullscreen(fullscreen)
end

-- fullscreen	(boolean)	Whether to enter or exit fullscreen mode.
-- fstype	(FullscreenType)	The type of fullscreen mode to use.
-- 
-- returns: success	(boolean)	True if successful, false otherwise.
function love.window.setFullscreen(fullscreen, fstype)
end

-- imagedata	(ImageData)	The window icon image.
-- 
-- returns: success	(boolean)	Whether the icon has been set successfully.
function love.window.setIcon(imagedata)
end

-- width	(number)	Display width.
-- height	(number)	Display height.
-- flags	(table)	The flags table with the options:
-- 
-- returns: success	(boolean)	True if successful, false otherwise.
function love.window.setMode(width, height, flags)
end

-- x	(number)	The x-coordinate of the window's position.
-- y	(number)	The y-coordinate of the window's position.
-- display	(number)	The index of the display that the new window position is relative to.
-- 
function love.window.setPosition(x, y, display)
end

-- title	(string)	The new window title.
-- 
function love.window.setTitle(title)
end

-- title	(string)	The title of the message box.
-- message	(string)	The text inside the message box.
-- type	(MessageBoxType)	The type of the message box.
-- attachtowindow	(boolean)	Whether the message box should be attached to the love window or free-floating.
-- 
-- returns: success	(boolean)	Whether the message box was successfully displayed.
function love.window.showMessageBox(title, message, type, attachtowindow)
end

-- title	(string)	The title of the message box.
-- message	(string)	The text inside the message box.
-- buttonlist	(table)	A table containing a list of button names to show. The table can also contain the fields enterbutton and escapebutton, which should be the index of the default button to use when the user presses 'enter' or 'escape', respectively.
-- type	(MessageBoxType)	The type of the message box.
-- attachtowindow	(boolean)	Whether the message box should be attached to the love window or free-floating.
-- 
-- returns: pressedbutton	(number)	The index of the button pressed by the user. May be 0 if the message box dialog was closed without pressing a button.
function love.window.showMessageBox(title, message, buttonlist, type, attachtowindow)
end

-- value	(number)	A number in density-independent units to convert to pixels.
-- 
-- returns: pixelvalue	(number)	The converted number, in pixels.
function love.window.toPixels(value)
end

-- x	(number)	The x-axis value of a coordinate in density-independent units to convert to pixels.
-- y	(number)	The y-axis value of a coordinate in density-independent units to convert to pixels.
-- 
-- returns: px	(number)	The converted x-axis value of the coordinate, in pixels.
-- returns: py	(number)	The converted y-axis value of the coordinate, in pixels.
function love.window.toPixels(x, y)
end

-- width	(number)	Window width.
-- height	(number)	Window height.
-- settings	(table)	The settings table with the following optional fields. Any field not filled in will use the current value that would be returned by love.window.getMode.
-- 
-- returns: success	(boolean)	True if successful, false otherwise.
function love.window.updateMode(width, height, settings)
end
