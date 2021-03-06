unit videodev2;

interface

{
  Most part of this file was converted by H2Pas 1.0.0 using 'h2pas -e -p videodev2.h'
  Some defines in videodev2.h which could not be implemented without functions was commented out.
  Anonymous unions were converted to named pascal unions with name 'u'.
  All V4L2_PIX_FMT_* and VIDIOC_* constans were prepared with another custom script.
  Note also manual insertions of 'packed record' and platform-dependent 'unsigned long userptr'.  
  Files 'v4l2-common.inc' and 'v4l2-controls.inc' are concatenated to this one.

  If you need to update this file you can try to compare provided 'videodev2.h'
  with a new version and update changes manually.
  Or you can try to run 'h2pas' again and compare result with this unit.
}

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


  {
   *  Video for Linux Two header file
   *
   *  Copyright (C) 1999-2012 the contributors
   *
   *  This program is free software; you can redistribute it and/or modify
   *  it under the terms of the GNU General Public License as published by
   *  the Free Software Foundation; either version 2 of the License, or
   *  (at your option) any later version.
   *
   *  This program is distributed in the hope that it will be useful,
   *  but WITHOUT ANY WARRANTY; without even the implied warranty of
   *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   *  GNU General Public License for more details.
   *
   *  Alternatively you can redistribute this file under the terms of the
   *  BSD license as stated below:
   *
   *  Redistribution and use in source and binary forms, with or without
   *  modification, are permitted provided that the following conditions
   *  are met:
   *  1. Redistributions of source code must retain the above copyright
   *     notice, this list of conditions and the following disclaimer.
   *  2. Redistributions in binary form must reproduce the above copyright
   *     notice, this list of conditions and the following disclaimer in
   *     the documentation and/or other materials provided with the
   *     distribution.
   *  3. The names of its contributors may not be used to endorse or promote
   *     products derived from this software without specific prior written
   *     permission.
   *
   *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
   *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
   *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
   *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
   *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
   *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
   *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
   *
   *	Header file for v4l or V4L2 drivers and applications
   * with public API.
   * All kernel-specific stuff were moved to media/v4l2-dev.h, so
   * no #if __KERNEL tests are allowed here
   *
   *	See http://linuxtv.org for more info
   *
   *	Author: Bill Dirks <bill@thedirks.org>
   *		Justin Schoeman
   *              Hans Verkuil <hverkuil@xs4all.nl>
   *		et al.
    }
{$ifndef _UAPI__LINUX_VIDEODEV2_H}
{$define _UAPI__LINUX_VIDEODEV2_H}  
{//#ifndef __KERNEL__}
{//#include <sys/time.h>}
type
  timeval = record
    tv_sec : longint;
    tv_usec : longint;
  end;

  timespec = record
    tv_sec: Longint;
    tv_nsec: Longint;
  end;
{//#endif}
{//#include <linux/compiler.h>}

{//#include <linux/ioctl.h>}
  const
     _IOC_NRBITS = 8;
     _IOC_TYPEBITS = 8;
     _IOC_SIZEBITS = 14;
     _IOC_DIRBITS = 2;
     _IOC_NRMASK = (1 shl _IOC_NRBITS)-1;
     _IOC_TYPEMASK = (1 shl _IOC_TYPEBITS)-1;
     _IOC_SIZEMASK = (1 shl _IOC_SIZEBITS)-1;
     _IOC_DIRMASK = (1 shl _IOC_DIRBITS)-1;
     _IOC_NRSHIFT = 0;
     _IOC_TYPESHIFT = _IOC_NRSHIFT+_IOC_NRBITS;
     _IOC_SIZESHIFT = _IOC_TYPESHIFT+_IOC_TYPEBITS;
     _IOC_DIRSHIFT = _IOC_SIZESHIFT+_IOC_SIZEBITS;
  {
   * Direction bits.
    }
     _IOC_NONE = 0;
     _IOC_WRITE = 1;
     _IOC_READ = 2;
{//#include <linux/types.h>}
type
  __u8 = byte;
  __s8 = shortint;
  __u16 = word;
  __s16 = smallint;
  __u32 = LongWord;
  __s32 = integer;
  __u64 = Int64;
  __s64 = Int64;

type
  __le32 = __u32;
{//#include <linux/v4l2-common.h>}
  {
   * include/linux/v4l2-common.h
   *
   * Common V4L2 and V4L2 subdev definitions.
   *
   * Users are advised to #include this file either through videodev2.h
   * (V4L2) or through v4l2-subdev.h (V4L2 subdev) rather than to refer
   * to this file directly.
   *
   * Copyright (C) 2012 Nokia Corporation
   * Contact: Sakari Ailus <sakari.ailus@iki.fi>
   *
   * This program is free software; you can redistribute it and/or
   * modify it under the terms of the GNU General Public License
   * version 2 as published by the Free Software Foundation.
   *
   * This program is distributed in the hope that it will be useful, but
   * WITHOUT ANY WARRANTY; without even the implied warranty of
   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   * General Public License for more details.
   *
   * You should have received a copy of the GNU General Public License
   * along with this program; if not, write to the Free Software
   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
   * 02110-1301 USA
   *
    }
{$ifndef __V4L2_COMMON__}
{$define __V4L2_COMMON__}  
  {
   *
   * Selection interface definitions
   *
    }
  { Current cropping area  }

  const
    V4L2_SEL_TGT_CROP = $0000;    
  { Default cropping area  }
    V4L2_SEL_TGT_CROP_DEFAULT = $0001;    
  { Cropping bounds  }
    V4L2_SEL_TGT_CROP_BOUNDS = $0002;    
  { Current composing area  }
    V4L2_SEL_TGT_COMPOSE = $0100;    
  { Default composing area  }
    V4L2_SEL_TGT_COMPOSE_DEFAULT = $0101;    
  { Composing bounds  }
    V4L2_SEL_TGT_COMPOSE_BOUNDS = $0102;    
  { Current composing area plus all padding pixels  }
    V4L2_SEL_TGT_COMPOSE_PADDED = $0103;    
  { Backward compatibility target definitions --- to be removed.  }
    V4L2_SEL_TGT_CROP_ACTIVE = V4L2_SEL_TGT_CROP;    
    V4L2_SEL_TGT_COMPOSE_ACTIVE = V4L2_SEL_TGT_COMPOSE;    
    V4L2_SUBDEV_SEL_TGT_CROP_ACTUAL = V4L2_SEL_TGT_CROP;    
    V4L2_SUBDEV_SEL_TGT_COMPOSE_ACTUAL = V4L2_SEL_TGT_COMPOSE;    
    V4L2_SUBDEV_SEL_TGT_CROP_BOUNDS = V4L2_SEL_TGT_CROP_BOUNDS;    
    V4L2_SUBDEV_SEL_TGT_COMPOSE_BOUNDS = V4L2_SEL_TGT_COMPOSE_BOUNDS;    
  { Selection flags  }
    V4L2_SEL_FLAG_GE = 1 shl 0;    
    V4L2_SEL_FLAG_LE = 1 shl 1;    
    V4L2_SEL_FLAG_KEEP_CONFIG = 1 shl 2;    
  { Backward compatibility flag definitions --- to be removed.  }
    V4L2_SUBDEV_SEL_FLAG_SIZE_GE = V4L2_SEL_FLAG_GE;    
    V4L2_SUBDEV_SEL_FLAG_SIZE_LE = V4L2_SEL_FLAG_LE;    
    V4L2_SUBDEV_SEL_FLAG_KEEP_CONFIG = V4L2_SEL_FLAG_KEEP_CONFIG;    
{$endif}
  { __V4L2_COMMON__  }
{//#include <linux/v4l2-controls.h>}
  {
   *  Video for Linux Two controls header file
   *
   *  Copyright (C) 1999-2012 the contributors
   *
   *  This program is free software; you can redistribute it and/or modify
   *  it under the terms of the GNU General Public License as published by
   *  the Free Software Foundation; either version 2 of the License, or
   *  (at your option) any later version.
   *
   *  This program is distributed in the hope that it will be useful,
   *  but WITHOUT ANY WARRANTY; without even the implied warranty of
   *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   *  GNU General Public License for more details.
   *
   *  Alternatively you can redistribute this file under the terms of the
   *  BSD license as stated below:
   *
   *  Redistribution and use in source and binary forms, with or without
   *  modification, are permitted provided that the following conditions
   *  are met:
   *  1. Redistributions of source code must retain the above copyright
   *     notice, this list of conditions and the following disclaimer.
   *  2. Redistributions in binary form must reproduce the above copyright
   *     notice, this list of conditions and the following disclaimer in
   *     the documentation and/or other materials provided with the
   *     distribution.
   *  3. The names of its contributors may not be used to endorse or promote
   *     products derived from this software without specific prior written
   *     permission.
   *
   *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
   *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
   *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
   *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
   *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
   *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
   *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
   *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
   *
   *  The contents of this header was split off from videodev2.h. All control
   *  definitions should be added to this header, which is included by
   *  videodev2.h.
    }
{$ifndef __LINUX_V4L2_CONTROLS_H}
{$define __LINUX_V4L2_CONTROLS_H}  
  { Control classes  }
  const
    V4L2_CTRL_CLASS_USER         = $00980000; { Old-style 'user' controls  }
    V4L2_CTRL_CLASS_MPEG         = $00990000; { MPEG-compression controls  }
    V4L2_CTRL_CLASS_CAMERA       = $009a0000; { Camera class controls  }
    V4L2_CTRL_CLASS_FM_TX        = $009b0000; { FM Modulator controls  }
    V4L2_CTRL_CLASS_FLASH        = $009c0000; { Camera flash controls  }
    V4L2_CTRL_CLASS_JPEG         = $009d0000; { JPEG-compression controls  }
    V4L2_CTRL_CLASS_IMAGE_SOURCE = $009e0000; { Image source controls  }
    V4L2_CTRL_CLASS_IMAGE_PROC   = $009f0000; { Image processing controls  }
    V4L2_CTRL_CLASS_DV           = $00a00000; { Digital Video controls  }
    V4L2_CTRL_CLASS_FM_RX        = $00a10000; { FM Receiver controls  }
  { User-class control IDs  }
    V4L2_CID_BASE = V4L2_CTRL_CLASS_USER or $900;    
    V4L2_CID_USER_BASE = V4L2_CID_BASE;    
    V4L2_CID_USER_CLASS = V4L2_CTRL_CLASS_USER or 1;    
    V4L2_CID_BRIGHTNESS = V4L2_CID_BASE+0;    
    V4L2_CID_CONTRAST = V4L2_CID_BASE+1;    
    V4L2_CID_SATURATION = V4L2_CID_BASE+2;    
    V4L2_CID_HUE = V4L2_CID_BASE+3;    
    V4L2_CID_AUDIO_VOLUME = V4L2_CID_BASE+5;    
    V4L2_CID_AUDIO_BALANCE = V4L2_CID_BASE+6;    
    V4L2_CID_AUDIO_BASS = V4L2_CID_BASE+7;    
    V4L2_CID_AUDIO_TREBLE = V4L2_CID_BASE+8;    
    V4L2_CID_AUDIO_MUTE = V4L2_CID_BASE+9;    
    V4L2_CID_AUDIO_LOUDNESS = V4L2_CID_BASE+10;    
    V4L2_CID_BLACK_LEVEL = V4L2_CID_BASE+11; { Deprecated  }
    V4L2_CID_AUTO_WHITE_BALANCE = V4L2_CID_BASE+12;    
    V4L2_CID_DO_WHITE_BALANCE = V4L2_CID_BASE+13;    
    V4L2_CID_RED_BALANCE = V4L2_CID_BASE+14;    
    V4L2_CID_BLUE_BALANCE = V4L2_CID_BASE+15;    
    V4L2_CID_GAMMA = V4L2_CID_BASE+16;
    V4L2_CID_WHITENESS = V4L2_CID_GAMMA; { Deprecated  }
    V4L2_CID_EXPOSURE = V4L2_CID_BASE+17;    
    V4L2_CID_AUTOGAIN = V4L2_CID_BASE+18;    
    V4L2_CID_GAIN = V4L2_CID_BASE+19;    
    V4L2_CID_HFLIP = V4L2_CID_BASE+20;    
    V4L2_CID_VFLIP = V4L2_CID_BASE+21;    
    V4L2_CID_POWER_LINE_FREQUENCY = V4L2_CID_BASE+24;    

  type
    v4l2_power_line_frequency =  Longint;
    Const
      V4L2_CID_POWER_LINE_FREQUENCY_DISABLED = 0;
      V4L2_CID_POWER_LINE_FREQUENCY_50HZ = 1;
      V4L2_CID_POWER_LINE_FREQUENCY_60HZ = 2;
      V4L2_CID_POWER_LINE_FREQUENCY_AUTO = 3;

    V4L2_CID_HUE_AUTO = V4L2_CID_BASE+25;    
    V4L2_CID_WHITE_BALANCE_TEMPERATURE = V4L2_CID_BASE+26;    
    V4L2_CID_SHARPNESS = V4L2_CID_BASE+27;    
    V4L2_CID_BACKLIGHT_COMPENSATION = V4L2_CID_BASE+28;    
    V4L2_CID_CHROMA_AGC = V4L2_CID_BASE+29;    
    V4L2_CID_COLOR_KILLER = V4L2_CID_BASE+30;    
    V4L2_CID_COLORFX = V4L2_CID_BASE+31;    

  type
    v4l2_colorfx =  Longint;
    Const
      V4L2_COLORFX_NONE = 0;
      V4L2_COLORFX_BW = 1;
      V4L2_COLORFX_SEPIA = 2;
      V4L2_COLORFX_NEGATIVE = 3;
      V4L2_COLORFX_EMBOSS = 4;
      V4L2_COLORFX_SKETCH = 5;
      V4L2_COLORFX_SKY_BLUE = 6;
      V4L2_COLORFX_GRASS_GREEN = 7;
      V4L2_COLORFX_SKIN_WHITEN = 8;
      V4L2_COLORFX_VIVID = 9;
      V4L2_COLORFX_AQUA = 10;
      V4L2_COLORFX_ART_FREEZE = 11;
      V4L2_COLORFX_SILHOUETTE = 12;
      V4L2_COLORFX_SOLARIZATION = 13;
      V4L2_COLORFX_ANTIQUE = 14;
      V4L2_COLORFX_SET_CBCR = 15;

    V4L2_CID_AUTOBRIGHTNESS = V4L2_CID_BASE+32;    
    V4L2_CID_BAND_STOP_FILTER = V4L2_CID_BASE+33;    
    V4L2_CID_ROTATE = V4L2_CID_BASE+34;    
    V4L2_CID_BG_COLOR = V4L2_CID_BASE+35;    
    V4L2_CID_CHROMA_GAIN = V4L2_CID_BASE+36;    
    V4L2_CID_ILLUMINATORS_1 = V4L2_CID_BASE+37;    
    V4L2_CID_ILLUMINATORS_2 = V4L2_CID_BASE+38;    
    V4L2_CID_MIN_BUFFERS_FOR_CAPTURE = V4L2_CID_BASE+39;    
    V4L2_CID_MIN_BUFFERS_FOR_OUTPUT = V4L2_CID_BASE+40;    
    V4L2_CID_ALPHA_COMPONENT = V4L2_CID_BASE+41;    
    V4L2_CID_COLORFX_CBCR = V4L2_CID_BASE+42;    
  { last CID + 1  }
    V4L2_CID_LASTP1 = V4L2_CID_BASE+43;    
  { USER-class private control IDs  }
  { The base for the meye driver controls. See linux/meye.h for the list
   * of controls. We reserve 16 controls for this driver.  }
    V4L2_CID_USER_MEYE_BASE = V4L2_CID_USER_BASE+$1000;    
  { The base for the bttv driver controls.
   * We reserve 32 controls for this driver.  }
    V4L2_CID_USER_BTTV_BASE = V4L2_CID_USER_BASE+$1010;    
  { The base for the s2255 driver controls.
   * We reserve 16 controls for this driver.  }
    V4L2_CID_USER_S2255_BASE = V4L2_CID_USER_BASE+$1030;    
  { The base for the si476x driver controls. See include/media/si476x.h for the list
   * of controls. Total of 16 controls is reserved for this driver  }
    V4L2_CID_USER_SI476X_BASE = V4L2_CID_USER_BASE+$1040;    
  { MPEG-class control IDs  }
  { The MPEG controls are applicable to all codec controls
   * and the 'MPEG' part of the define is historical  }
    V4L2_CID_MPEG_BASE = V4L2_CTRL_CLASS_MPEG or $900;    
    V4L2_CID_MPEG_CLASS = V4L2_CTRL_CLASS_MPEG or 1;    
  {  MPEG streams, specific to multiplexed streams  }
    V4L2_CID_MPEG_STREAM_TYPE = V4L2_CID_MPEG_BASE+0;    
  { MPEG-2 program stream  }
  { MPEG-2 transport stream  }
  { MPEG-1 system stream  }
  { MPEG-2 DVD-compatible stream  }
  { MPEG-1 VCD-compatible stream  }
  { MPEG-2 SVCD-compatible stream  }

  type
    v4l2_mpeg_stream_type =  Longint;
    Const
      V4L2_MPEG_STREAM_TYPE_MPEG2_PS = 0;
      V4L2_MPEG_STREAM_TYPE_MPEG2_TS = 1;
      V4L2_MPEG_STREAM_TYPE_MPEG1_SS = 2;
      V4L2_MPEG_STREAM_TYPE_MPEG2_DVD = 3;
      V4L2_MPEG_STREAM_TYPE_MPEG1_VCD = 4;
      V4L2_MPEG_STREAM_TYPE_MPEG2_SVCD = 5;

    V4L2_CID_MPEG_STREAM_PID_PMT = V4L2_CID_MPEG_BASE+1;    
    V4L2_CID_MPEG_STREAM_PID_AUDIO = V4L2_CID_MPEG_BASE+2;    
    V4L2_CID_MPEG_STREAM_PID_VIDEO = V4L2_CID_MPEG_BASE+3;    
    V4L2_CID_MPEG_STREAM_PID_PCR = V4L2_CID_MPEG_BASE+4;    
    V4L2_CID_MPEG_STREAM_PES_ID_AUDIO = V4L2_CID_MPEG_BASE+5;    
    V4L2_CID_MPEG_STREAM_PES_ID_VIDEO = V4L2_CID_MPEG_BASE+6;    
    V4L2_CID_MPEG_STREAM_VBI_FMT = V4L2_CID_MPEG_BASE+7;    
  { No VBI in the MPEG stream  }
  { VBI in private packets, IVTV format  }

  type
    v4l2_mpeg_stream_vbi_fmt =  Longint;
    Const
      V4L2_MPEG_STREAM_VBI_FMT_NONE = 0;
      V4L2_MPEG_STREAM_VBI_FMT_IVTV = 1;

  {  MPEG audio controls specific to multiplexed streams   }
    V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ = V4L2_CID_MPEG_BASE+100;    

  type
    v4l2_mpeg_audio_sampling_freq =  Longint;
    Const
      V4L2_MPEG_AUDIO_SAMPLING_FREQ_44100 = 0;
      V4L2_MPEG_AUDIO_SAMPLING_FREQ_48000 = 1;
      V4L2_MPEG_AUDIO_SAMPLING_FREQ_32000 = 2;

    V4L2_CID_MPEG_AUDIO_ENCODING = V4L2_CID_MPEG_BASE+101;    

  type
    v4l2_mpeg_audio_encoding =  Longint;
    Const
      V4L2_MPEG_AUDIO_ENCODING_LAYER_1 = 0;
      V4L2_MPEG_AUDIO_ENCODING_LAYER_2 = 1;
      V4L2_MPEG_AUDIO_ENCODING_LAYER_3 = 2;
      V4L2_MPEG_AUDIO_ENCODING_AAC = 3;
      V4L2_MPEG_AUDIO_ENCODING_AC3 = 4;

    V4L2_CID_MPEG_AUDIO_L1_BITRATE = V4L2_CID_MPEG_BASE+102;    

  type
    v4l2_mpeg_audio_l1_bitrate =  Longint;
    Const
      V4L2_MPEG_AUDIO_L1_BITRATE_32K = 0;
      V4L2_MPEG_AUDIO_L1_BITRATE_64K = 1;
      V4L2_MPEG_AUDIO_L1_BITRATE_96K = 2;
      V4L2_MPEG_AUDIO_L1_BITRATE_128K = 3;
      V4L2_MPEG_AUDIO_L1_BITRATE_160K = 4;
      V4L2_MPEG_AUDIO_L1_BITRATE_192K = 5;
      V4L2_MPEG_AUDIO_L1_BITRATE_224K = 6;
      V4L2_MPEG_AUDIO_L1_BITRATE_256K = 7;
      V4L2_MPEG_AUDIO_L1_BITRATE_288K = 8;
      V4L2_MPEG_AUDIO_L1_BITRATE_320K = 9;
      V4L2_MPEG_AUDIO_L1_BITRATE_352K = 10;
      V4L2_MPEG_AUDIO_L1_BITRATE_384K = 11;
      V4L2_MPEG_AUDIO_L1_BITRATE_416K = 12;
      V4L2_MPEG_AUDIO_L1_BITRATE_448K = 13;

    V4L2_CID_MPEG_AUDIO_L2_BITRATE = V4L2_CID_MPEG_BASE+103;    

  type
    v4l2_mpeg_audio_l2_bitrate =  Longint;
    Const
      V4L2_MPEG_AUDIO_L2_BITRATE_32K = 0;
      V4L2_MPEG_AUDIO_L2_BITRATE_48K = 1;
      V4L2_MPEG_AUDIO_L2_BITRATE_56K = 2;
      V4L2_MPEG_AUDIO_L2_BITRATE_64K = 3;
      V4L2_MPEG_AUDIO_L2_BITRATE_80K = 4;
      V4L2_MPEG_AUDIO_L2_BITRATE_96K = 5;
      V4L2_MPEG_AUDIO_L2_BITRATE_112K = 6;
      V4L2_MPEG_AUDIO_L2_BITRATE_128K = 7;
      V4L2_MPEG_AUDIO_L2_BITRATE_160K = 8;
      V4L2_MPEG_AUDIO_L2_BITRATE_192K = 9;
      V4L2_MPEG_AUDIO_L2_BITRATE_224K = 10;
      V4L2_MPEG_AUDIO_L2_BITRATE_256K = 11;
      V4L2_MPEG_AUDIO_L2_BITRATE_320K = 12;
      V4L2_MPEG_AUDIO_L2_BITRATE_384K = 13;

    V4L2_CID_MPEG_AUDIO_L3_BITRATE = V4L2_CID_MPEG_BASE+104;    

  type
    v4l2_mpeg_audio_l3_bitrate =  Longint;
    Const
      V4L2_MPEG_AUDIO_L3_BITRATE_32K = 0;
      V4L2_MPEG_AUDIO_L3_BITRATE_40K = 1;
      V4L2_MPEG_AUDIO_L3_BITRATE_48K = 2;
      V4L2_MPEG_AUDIO_L3_BITRATE_56K = 3;
      V4L2_MPEG_AUDIO_L3_BITRATE_64K = 4;
      V4L2_MPEG_AUDIO_L3_BITRATE_80K = 5;
      V4L2_MPEG_AUDIO_L3_BITRATE_96K = 6;
      V4L2_MPEG_AUDIO_L3_BITRATE_112K = 7;
      V4L2_MPEG_AUDIO_L3_BITRATE_128K = 8;
      V4L2_MPEG_AUDIO_L3_BITRATE_160K = 9;
      V4L2_MPEG_AUDIO_L3_BITRATE_192K = 10;
      V4L2_MPEG_AUDIO_L3_BITRATE_224K = 11;
      V4L2_MPEG_AUDIO_L3_BITRATE_256K = 12;
      V4L2_MPEG_AUDIO_L3_BITRATE_320K = 13;

    V4L2_CID_MPEG_AUDIO_MODE = V4L2_CID_MPEG_BASE+105;    

  type
    v4l2_mpeg_audio_mode =  Longint;
    Const
      V4L2_MPEG_AUDIO_MODE_STEREO = 0;
      V4L2_MPEG_AUDIO_MODE_JOINT_STEREO = 1;
      V4L2_MPEG_AUDIO_MODE_DUAL = 2;
      V4L2_MPEG_AUDIO_MODE_MONO = 3;

    V4L2_CID_MPEG_AUDIO_MODE_EXTENSION = V4L2_CID_MPEG_BASE+106;    

  type
    v4l2_mpeg_audio_mode_extension =  Longint;
    Const
      V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_4 = 0;
      V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_8 = 1;
      V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_12 = 2;
      V4L2_MPEG_AUDIO_MODE_EXTENSION_BOUND_16 = 3;

    V4L2_CID_MPEG_AUDIO_EMPHASIS = V4L2_CID_MPEG_BASE+107;    

  type
    v4l2_mpeg_audio_emphasis =  Longint;
    Const
      V4L2_MPEG_AUDIO_EMPHASIS_NONE = 0;
      V4L2_MPEG_AUDIO_EMPHASIS_50_DIV_15_uS = 1;
      V4L2_MPEG_AUDIO_EMPHASIS_CCITT_J17 = 2;

    V4L2_CID_MPEG_AUDIO_CRC = V4L2_CID_MPEG_BASE+108;    

  type
    v4l2_mpeg_audio_crc =  Longint;
    Const
      V4L2_MPEG_AUDIO_CRC_NONE = 0;
      V4L2_MPEG_AUDIO_CRC_CRC16 = 1;

    V4L2_CID_MPEG_AUDIO_MUTE = V4L2_CID_MPEG_BASE+109;    
    V4L2_CID_MPEG_AUDIO_AAC_BITRATE = V4L2_CID_MPEG_BASE+110;    
    V4L2_CID_MPEG_AUDIO_AC3_BITRATE = V4L2_CID_MPEG_BASE+111;    

  type
    v4l2_mpeg_audio_ac3_bitrate =  Longint;
    Const
      V4L2_MPEG_AUDIO_AC3_BITRATE_32K = 0;
      V4L2_MPEG_AUDIO_AC3_BITRATE_40K = 1;
      V4L2_MPEG_AUDIO_AC3_BITRATE_48K = 2;
      V4L2_MPEG_AUDIO_AC3_BITRATE_56K = 3;
      V4L2_MPEG_AUDIO_AC3_BITRATE_64K = 4;
      V4L2_MPEG_AUDIO_AC3_BITRATE_80K = 5;
      V4L2_MPEG_AUDIO_AC3_BITRATE_96K = 6;
      V4L2_MPEG_AUDIO_AC3_BITRATE_112K = 7;
      V4L2_MPEG_AUDIO_AC3_BITRATE_128K = 8;
      V4L2_MPEG_AUDIO_AC3_BITRATE_160K = 9;
      V4L2_MPEG_AUDIO_AC3_BITRATE_192K = 10;
      V4L2_MPEG_AUDIO_AC3_BITRATE_224K = 11;
      V4L2_MPEG_AUDIO_AC3_BITRATE_256K = 12;
      V4L2_MPEG_AUDIO_AC3_BITRATE_320K = 13;
      V4L2_MPEG_AUDIO_AC3_BITRATE_384K = 14;
      V4L2_MPEG_AUDIO_AC3_BITRATE_448K = 15;
      V4L2_MPEG_AUDIO_AC3_BITRATE_512K = 16;
      V4L2_MPEG_AUDIO_AC3_BITRATE_576K = 17;
      V4L2_MPEG_AUDIO_AC3_BITRATE_640K = 18;

    V4L2_CID_MPEG_AUDIO_DEC_PLAYBACK = V4L2_CID_MPEG_BASE+112;    

  type
    v4l2_mpeg_audio_dec_playback =  Longint;
    Const
      V4L2_MPEG_AUDIO_DEC_PLAYBACK_AUTO = 0;
      V4L2_MPEG_AUDIO_DEC_PLAYBACK_STEREO = 1;
      V4L2_MPEG_AUDIO_DEC_PLAYBACK_LEFT = 2;
      V4L2_MPEG_AUDIO_DEC_PLAYBACK_RIGHT = 3;
      V4L2_MPEG_AUDIO_DEC_PLAYBACK_MONO = 4;
      V4L2_MPEG_AUDIO_DEC_PLAYBACK_SWAPPED_STEREO = 5;

    V4L2_CID_MPEG_AUDIO_DEC_MULTILINGUAL_PLAYBACK = V4L2_CID_MPEG_BASE+113;    
  {  MPEG video controls specific to multiplexed streams  }
    V4L2_CID_MPEG_VIDEO_ENCODING = V4L2_CID_MPEG_BASE+200;    

  type
    v4l2_mpeg_video_encoding =  Longint;
    Const
      V4L2_MPEG_VIDEO_ENCODING_MPEG_1 = 0;
      V4L2_MPEG_VIDEO_ENCODING_MPEG_2 = 1;
      V4L2_MPEG_VIDEO_ENCODING_MPEG_4_AVC = 2;

    V4L2_CID_MPEG_VIDEO_ASPECT = V4L2_CID_MPEG_BASE+201;    

  type
    v4l2_mpeg_video_aspect =  Longint;
    Const
      V4L2_MPEG_VIDEO_ASPECT_1x1 = 0;
      V4L2_MPEG_VIDEO_ASPECT_4x3 = 1;
      V4L2_MPEG_VIDEO_ASPECT_16x9 = 2;
      V4L2_MPEG_VIDEO_ASPECT_221x100 = 3;

    V4L2_CID_MPEG_VIDEO_B_FRAMES = V4L2_CID_MPEG_BASE+202;    
    V4L2_CID_MPEG_VIDEO_GOP_SIZE = V4L2_CID_MPEG_BASE+203;    
    V4L2_CID_MPEG_VIDEO_GOP_CLOSURE = V4L2_CID_MPEG_BASE+204;    
    V4L2_CID_MPEG_VIDEO_PULLDOWN = V4L2_CID_MPEG_BASE+205;    
    V4L2_CID_MPEG_VIDEO_BITRATE_MODE = V4L2_CID_MPEG_BASE+206;    

  type
    v4l2_mpeg_video_bitrate_mode =  Longint;
    Const
      V4L2_MPEG_VIDEO_BITRATE_MODE_VBR = 0;
      V4L2_MPEG_VIDEO_BITRATE_MODE_CBR = 1;

    V4L2_CID_MPEG_VIDEO_BITRATE = V4L2_CID_MPEG_BASE+207;    
    V4L2_CID_MPEG_VIDEO_BITRATE_PEAK = V4L2_CID_MPEG_BASE+208;    
    V4L2_CID_MPEG_VIDEO_TEMPORAL_DECIMATION = V4L2_CID_MPEG_BASE+209;    
    V4L2_CID_MPEG_VIDEO_MUTE = V4L2_CID_MPEG_BASE+210;    
    V4L2_CID_MPEG_VIDEO_MUTE_YUV = V4L2_CID_MPEG_BASE+211;    
    V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE = V4L2_CID_MPEG_BASE+212;    
    V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER = V4L2_CID_MPEG_BASE+213;    
    V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB = V4L2_CID_MPEG_BASE+214;    
    V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE = V4L2_CID_MPEG_BASE+215;    
    V4L2_CID_MPEG_VIDEO_HEADER_MODE = V4L2_CID_MPEG_BASE+216;    

  type
    v4l2_mpeg_video_header_mode =  Longint;
    Const
      V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE = 0;
      V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME = 1;

    V4L2_CID_MPEG_VIDEO_MAX_REF_PIC = V4L2_CID_MPEG_BASE+217;    
    V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE = V4L2_CID_MPEG_BASE+218;    
    V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_BYTES = V4L2_CID_MPEG_BASE+219;    
    V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_MB = V4L2_CID_MPEG_BASE+220;    
    V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE = V4L2_CID_MPEG_BASE+221;    

  type
    v4l2_mpeg_video_multi_slice_mode =  Longint;
    Const
      V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE = 0;
      V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_MB = 1;
      V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES = 2;

    V4L2_CID_MPEG_VIDEO_VBV_SIZE = V4L2_CID_MPEG_BASE+222;    
    V4L2_CID_MPEG_VIDEO_DEC_PTS = V4L2_CID_MPEG_BASE+223;    
    V4L2_CID_MPEG_VIDEO_DEC_FRAME = V4L2_CID_MPEG_BASE+224;    
    V4L2_CID_MPEG_VIDEO_VBV_DELAY = V4L2_CID_MPEG_BASE+225;    
    V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER = V4L2_CID_MPEG_BASE+226;    
    V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP = V4L2_CID_MPEG_BASE+300;    
    V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP = V4L2_CID_MPEG_BASE+301;    
    V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP = V4L2_CID_MPEG_BASE+302;    
    V4L2_CID_MPEG_VIDEO_H263_MIN_QP = V4L2_CID_MPEG_BASE+303;    
    V4L2_CID_MPEG_VIDEO_H263_MAX_QP = V4L2_CID_MPEG_BASE+304;    
    V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP = V4L2_CID_MPEG_BASE+350;    
    V4L2_CID_MPEG_VIDEO_H264_P_FRAME_QP = V4L2_CID_MPEG_BASE+351;    
    V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP = V4L2_CID_MPEG_BASE+352;    
    V4L2_CID_MPEG_VIDEO_H264_MIN_QP = V4L2_CID_MPEG_BASE+353;    
    V4L2_CID_MPEG_VIDEO_H264_MAX_QP = V4L2_CID_MPEG_BASE+354;    
    V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM = V4L2_CID_MPEG_BASE+355;    
    V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE = V4L2_CID_MPEG_BASE+356;    
    V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE = V4L2_CID_MPEG_BASE+357;    

  type
    v4l2_mpeg_video_h264_entropy_mode =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC = 0;
      V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC = 1;

    V4L2_CID_MPEG_VIDEO_H264_I_PERIOD = V4L2_CID_MPEG_BASE+358;    
    V4L2_CID_MPEG_VIDEO_H264_LEVEL = V4L2_CID_MPEG_BASE+359;    

  type
    v4l2_mpeg_video_h264_level =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_LEVEL_1_0 = 0;
      V4L2_MPEG_VIDEO_H264_LEVEL_1B = 1;
      V4L2_MPEG_VIDEO_H264_LEVEL_1_1 = 2;
      V4L2_MPEG_VIDEO_H264_LEVEL_1_2 = 3;
      V4L2_MPEG_VIDEO_H264_LEVEL_1_3 = 4;
      V4L2_MPEG_VIDEO_H264_LEVEL_2_0 = 5;
      V4L2_MPEG_VIDEO_H264_LEVEL_2_1 = 6;
      V4L2_MPEG_VIDEO_H264_LEVEL_2_2 = 7;
      V4L2_MPEG_VIDEO_H264_LEVEL_3_0 = 8;
      V4L2_MPEG_VIDEO_H264_LEVEL_3_1 = 9;
      V4L2_MPEG_VIDEO_H264_LEVEL_3_2 = 10;
      V4L2_MPEG_VIDEO_H264_LEVEL_4_0 = 11;
      V4L2_MPEG_VIDEO_H264_LEVEL_4_1 = 12;
      V4L2_MPEG_VIDEO_H264_LEVEL_4_2 = 13;
      V4L2_MPEG_VIDEO_H264_LEVEL_5_0 = 14;
      V4L2_MPEG_VIDEO_H264_LEVEL_5_1 = 15;

    V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA = V4L2_CID_MPEG_BASE+360;    
    V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA = V4L2_CID_MPEG_BASE+361;    
    V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_MODE = V4L2_CID_MPEG_BASE+362;    

  type
    v4l2_mpeg_video_h264_loop_filter_mode =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_ENABLED = 0;
      V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED = 1;
      V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY = 2;

    V4L2_CID_MPEG_VIDEO_H264_PROFILE = V4L2_CID_MPEG_BASE+363;    

  type
    v4l2_mpeg_video_h264_profile =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE = 0;
      V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE = 1;
      V4L2_MPEG_VIDEO_H264_PROFILE_MAIN = 2;
      V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED = 3;
      V4L2_MPEG_VIDEO_H264_PROFILE_HIGH = 4;
      V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10 = 5;
      V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422 = 6;
      V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE = 7;
      V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10_INTRA = 8;
      V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422_INTRA = 9;
      V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_INTRA = 10;
      V4L2_MPEG_VIDEO_H264_PROFILE_CAVLC_444_INTRA = 11;
      V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_BASELINE = 12;
      V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH = 13;
      V4L2_MPEG_VIDEO_H264_PROFILE_SCALABLE_HIGH_INTRA = 14;
      V4L2_MPEG_VIDEO_H264_PROFILE_STEREO_HIGH = 15;
      V4L2_MPEG_VIDEO_H264_PROFILE_MULTIVIEW_HIGH = 16;

    V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_HEIGHT = V4L2_CID_MPEG_BASE+364;    
    V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_WIDTH = V4L2_CID_MPEG_BASE+365;    
    V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE = V4L2_CID_MPEG_BASE+366;    
    V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC = V4L2_CID_MPEG_BASE+367;    

  type
    v4l2_mpeg_video_h264_vui_sar_idc =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_UNSPECIFIED = 0;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_1x1 = 1;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_12x11 = 2;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_10x11 = 3;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_16x11 = 4;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_40x33 = 5;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_24x11 = 6;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_20x11 = 7;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_32x11 = 8;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_80x33 = 9;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_18x11 = 10;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_15x11 = 11;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_64x33 = 12;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_160x99 = 13;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_4x3 = 14;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_3x2 = 15;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_2x1 = 16;
      V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_EXTENDED = 17;

    V4L2_CID_MPEG_VIDEO_H264_SEI_FRAME_PACKING = V4L2_CID_MPEG_BASE+368;    
    V4L2_CID_MPEG_VIDEO_H264_SEI_FP_CURRENT_FRAME_0 = V4L2_CID_MPEG_BASE+369;    
    V4L2_CID_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE = V4L2_CID_MPEG_BASE+370;    

  type
    v4l2_mpeg_video_h264_sei_fp_arrangement_type =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_CHECKERBOARD = 0;
      V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_COLUMN = 1;
      V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_ROW = 2;
      V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_SIDE_BY_SIDE = 3;
      V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_TOP_BOTTOM = 4;
      V4L2_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE_TEMPORAL = 5;

    V4L2_CID_MPEG_VIDEO_H264_FMO = V4L2_CID_MPEG_BASE+371;    
    V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE = V4L2_CID_MPEG_BASE+372;    

  type
    v4l2_mpeg_video_h264_fmo_map_type =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_INTERLEAVED_SLICES = 0;
      V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_SCATTERED_SLICES = 1;
      V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_FOREGROUND_WITH_LEFT_OVER = 2;
      V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_BOX_OUT = 3;
      V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_RASTER_SCAN = 4;
      V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_WIPE_SCAN = 5;
      V4L2_MPEG_VIDEO_H264_FMO_MAP_TYPE_EXPLICIT = 6;

    V4L2_CID_MPEG_VIDEO_H264_FMO_SLICE_GROUP = V4L2_CID_MPEG_BASE+373;    
    V4L2_CID_MPEG_VIDEO_H264_FMO_CHANGE_DIRECTION = V4L2_CID_MPEG_BASE+374;    

  type
    v4l2_mpeg_video_h264_fmo_change_dir =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_FMO_CHANGE_DIR_RIGHT = 0;
      V4L2_MPEG_VIDEO_H264_FMO_CHANGE_DIR_LEFT = 1;

    V4L2_CID_MPEG_VIDEO_H264_FMO_CHANGE_RATE = V4L2_CID_MPEG_BASE+375;    
    V4L2_CID_MPEG_VIDEO_H264_FMO_RUN_LENGTH = V4L2_CID_MPEG_BASE+376;    
    V4L2_CID_MPEG_VIDEO_H264_ASO = V4L2_CID_MPEG_BASE+377;    
    V4L2_CID_MPEG_VIDEO_H264_ASO_SLICE_ORDER = V4L2_CID_MPEG_BASE+378;    
    V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING = V4L2_CID_MPEG_BASE+379;    
    V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE = V4L2_CID_MPEG_BASE+380;    

  type
    v4l2_mpeg_video_h264_hierarchical_coding_type =  Longint;
    Const
      V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_B = 0;
      V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_P = 1;

    V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER = V4L2_CID_MPEG_BASE+381;    
    V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP = V4L2_CID_MPEG_BASE+382;    
    V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP = V4L2_CID_MPEG_BASE+400;    
    V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP = V4L2_CID_MPEG_BASE+401;    
    V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP = V4L2_CID_MPEG_BASE+402;    
    V4L2_CID_MPEG_VIDEO_MPEG4_MIN_QP = V4L2_CID_MPEG_BASE+403;    
    V4L2_CID_MPEG_VIDEO_MPEG4_MAX_QP = V4L2_CID_MPEG_BASE+404;    
    V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL = V4L2_CID_MPEG_BASE+405;    

  type
    v4l2_mpeg_video_mpeg4_level =  Longint;
    Const
      V4L2_MPEG_VIDEO_MPEG4_LEVEL_0 = 0;
      V4L2_MPEG_VIDEO_MPEG4_LEVEL_0B = 1;
      V4L2_MPEG_VIDEO_MPEG4_LEVEL_1 = 2;
      V4L2_MPEG_VIDEO_MPEG4_LEVEL_2 = 3;
      V4L2_MPEG_VIDEO_MPEG4_LEVEL_3 = 4;
      V4L2_MPEG_VIDEO_MPEG4_LEVEL_3B = 5;
      V4L2_MPEG_VIDEO_MPEG4_LEVEL_4 = 6;
      V4L2_MPEG_VIDEO_MPEG4_LEVEL_5 = 7;

    V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE = V4L2_CID_MPEG_BASE+406;    

  type
    v4l2_mpeg_video_mpeg4_profile =  Longint;
    Const
      V4L2_MPEG_VIDEO_MPEG4_PROFILE_SIMPLE = 0;
      V4L2_MPEG_VIDEO_MPEG4_PROFILE_ADVANCED_SIMPLE = 1;
      V4L2_MPEG_VIDEO_MPEG4_PROFILE_CORE = 2;
      V4L2_MPEG_VIDEO_MPEG4_PROFILE_SIMPLE_SCALABLE = 3;
      V4L2_MPEG_VIDEO_MPEG4_PROFILE_ADVANCED_CODING_EFFICIENCY = 4;

    V4L2_CID_MPEG_VIDEO_MPEG4_QPEL = V4L2_CID_MPEG_BASE+407;    
  {  Control IDs for VP8 streams
   *  Although VP8 is not part of MPEG we add these controls to the MPEG class
   *  as that class is already handling other video compression standards
    }
    V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS = V4L2_CID_MPEG_BASE+500;    

  type
    v4l2_vp8_num_partitions =  Longint;
    Const
      V4L2_CID_MPEG_VIDEO_VPX_1_PARTITION = 0;
      V4L2_CID_MPEG_VIDEO_VPX_2_PARTITIONS = 1;
      V4L2_CID_MPEG_VIDEO_VPX_4_PARTITIONS = 2;
      V4L2_CID_MPEG_VIDEO_VPX_8_PARTITIONS = 3;

    V4L2_CID_MPEG_VIDEO_VPX_IMD_DISABLE_4X4 = V4L2_CID_MPEG_BASE+501;    
    V4L2_CID_MPEG_VIDEO_VPX_NUM_REF_FRAMES = V4L2_CID_MPEG_BASE+502;    

  type
    v4l2_vp8_num_ref_frames =  Longint;
    Const
      V4L2_CID_MPEG_VIDEO_VPX_1_REF_FRAME = 0;
      V4L2_CID_MPEG_VIDEO_VPX_2_REF_FRAME = 1;
      V4L2_CID_MPEG_VIDEO_VPX_3_REF_FRAME = 2;

    V4L2_CID_MPEG_VIDEO_VPX_FILTER_LEVEL = V4L2_CID_MPEG_BASE+503;    
    V4L2_CID_MPEG_VIDEO_VPX_FILTER_SHARPNESS = V4L2_CID_MPEG_BASE+504;    
    V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_REF_PERIOD = V4L2_CID_MPEG_BASE+505;    
    V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL = V4L2_CID_MPEG_BASE+506;    

  type
    v4l2_vp8_golden_frame_sel =  Longint;
    Const
      V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_USE_PREV = 0;
      V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_USE_REF_PERIOD = 1;

  {  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2  }
    V4L2_CID_MPEG_CX2341X_BASE = V4L2_CTRL_CLASS_MPEG or $1000;    
    V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE = V4L2_CID_MPEG_CX2341X_BASE+0;    

  type
    v4l2_mpeg_cx2341x_video_spatial_filter_mode =  Longint;
    Const
      V4L2_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE_MANUAL = 0;
      V4L2_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE_AUTO = 1;

    V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER = V4L2_CID_MPEG_CX2341X_BASE+1;    
    V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE = V4L2_CID_MPEG_CX2341X_BASE+2;    

  type
    v4l2_mpeg_cx2341x_video_luma_spatial_filter_type =  Longint;
    Const
      V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_OFF = 0;
      V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_1D_HOR = 1;
      V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_1D_VERT = 2;
      V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_2D_HV_SEPARABLE = 3;
      V4L2_MPEG_CX2341X_VIDEO_LUMA_SPATIAL_FILTER_TYPE_2D_SYM_NON_SEPARABLE = 4;

    V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE = V4L2_CID_MPEG_CX2341X_BASE+3;    

  type
    v4l2_mpeg_cx2341x_video_chroma_spatial_filter_type =  Longint;
    Const
      V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_OFF = 0;
      V4L2_MPEG_CX2341X_VIDEO_CHROMA_SPATIAL_FILTER_TYPE_1D_HOR = 1;

    V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE = V4L2_CID_MPEG_CX2341X_BASE+4;    

  type
    v4l2_mpeg_cx2341x_video_temporal_filter_mode =  Longint;
    Const
      V4L2_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE_MANUAL = 0;
      V4L2_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER_MODE_AUTO = 1;

    V4L2_CID_MPEG_CX2341X_VIDEO_TEMPORAL_FILTER = V4L2_CID_MPEG_CX2341X_BASE+5;    
    V4L2_CID_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE = V4L2_CID_MPEG_CX2341X_BASE+6;    

  type
    v4l2_mpeg_cx2341x_video_median_filter_type =  Longint;
    Const
      V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_OFF = 0;
      V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_HOR = 1;
      V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_VERT = 2;
      V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_HOR_VERT = 3;
      V4L2_MPEG_CX2341X_VIDEO_MEDIAN_FILTER_TYPE_DIAG = 4;

    V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_BOTTOM = V4L2_CID_MPEG_CX2341X_BASE+7;    
    V4L2_CID_MPEG_CX2341X_VIDEO_LUMA_MEDIAN_FILTER_TOP = V4L2_CID_MPEG_CX2341X_BASE+8;    
    V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_BOTTOM = V4L2_CID_MPEG_CX2341X_BASE+9;    
    V4L2_CID_MPEG_CX2341X_VIDEO_CHROMA_MEDIAN_FILTER_TOP = V4L2_CID_MPEG_CX2341X_BASE+10;    
    V4L2_CID_MPEG_CX2341X_STREAM_INSERT_NAV_PACKETS = V4L2_CID_MPEG_CX2341X_BASE+11;    
  {  MPEG-class control IDs specific to the Samsung MFC 5.1 driver as defined by V4L2  }
    V4L2_CID_MPEG_MFC51_BASE = V4L2_CTRL_CLASS_MPEG or $1100;    
    V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY = V4L2_CID_MPEG_MFC51_BASE+0;    
    V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY_ENABLE = V4L2_CID_MPEG_MFC51_BASE+1;    
    V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE = V4L2_CID_MPEG_MFC51_BASE+2;    

  type
    v4l2_mpeg_mfc51_video_frame_skip_mode =  Longint;
    Const
      V4L2_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE_DISABLED = 0;
      V4L2_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE_LEVEL_LIMIT = 1;
      V4L2_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT = 2;

    V4L2_CID_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE = V4L2_CID_MPEG_MFC51_BASE+3;    

  type
    v4l2_mpeg_mfc51_video_force_frame_type =  Longint;
    Const
      V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_DISABLED = 0;
      V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_I_FRAME = 1;
      V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_NOT_CODED = 2;

    V4L2_CID_MPEG_MFC51_VIDEO_PADDING = V4L2_CID_MPEG_MFC51_BASE+4;    
    V4L2_CID_MPEG_MFC51_VIDEO_PADDING_YUV = V4L2_CID_MPEG_MFC51_BASE+5;    
    V4L2_CID_MPEG_MFC51_VIDEO_RC_FIXED_TARGET_BIT = V4L2_CID_MPEG_MFC51_BASE+6;    
    V4L2_CID_MPEG_MFC51_VIDEO_RC_REACTION_COEFF = V4L2_CID_MPEG_MFC51_BASE+7;    
    V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_ACTIVITY = V4L2_CID_MPEG_MFC51_BASE+50;    
    V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_DARK = V4L2_CID_MPEG_MFC51_BASE+51;    
    V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_SMOOTH = V4L2_CID_MPEG_MFC51_BASE+52;    
    V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_STATIC = V4L2_CID_MPEG_MFC51_BASE+53;    
    V4L2_CID_MPEG_MFC51_VIDEO_H264_NUM_REF_PIC_FOR_P = V4L2_CID_MPEG_MFC51_BASE+54;    
  {  Camera class control IDs  }
    V4L2_CID_CAMERA_CLASS_BASE = V4L2_CTRL_CLASS_CAMERA or $900;    
    V4L2_CID_CAMERA_CLASS = V4L2_CTRL_CLASS_CAMERA or 1;    
    V4L2_CID_EXPOSURE_AUTO = V4L2_CID_CAMERA_CLASS_BASE+1;    

  type
    v4l2_exposure_auto_type =  Longint;
    Const
      V4L2_EXPOSURE_AUTO = 0;
      V4L2_EXPOSURE_MANUAL = 1;
      V4L2_EXPOSURE_SHUTTER_PRIORITY = 2;
      V4L2_EXPOSURE_APERTURE_PRIORITY = 3;

    V4L2_CID_EXPOSURE_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+2;    
    V4L2_CID_EXPOSURE_AUTO_PRIORITY = V4L2_CID_CAMERA_CLASS_BASE+3;    
    V4L2_CID_PAN_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+4;    
    V4L2_CID_TILT_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+5;    
    V4L2_CID_PAN_RESET = V4L2_CID_CAMERA_CLASS_BASE+6;    
    V4L2_CID_TILT_RESET = V4L2_CID_CAMERA_CLASS_BASE+7;    
    V4L2_CID_PAN_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+8;    
    V4L2_CID_TILT_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+9;    
    V4L2_CID_FOCUS_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+10;    
    V4L2_CID_FOCUS_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+11;    
    V4L2_CID_FOCUS_AUTO = V4L2_CID_CAMERA_CLASS_BASE+12;    
    V4L2_CID_ZOOM_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+13;    
    V4L2_CID_ZOOM_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+14;    
    V4L2_CID_ZOOM_CONTINUOUS = V4L2_CID_CAMERA_CLASS_BASE+15;    
    V4L2_CID_PRIVACY = V4L2_CID_CAMERA_CLASS_BASE+16;    
    V4L2_CID_IRIS_ABSOLUTE = V4L2_CID_CAMERA_CLASS_BASE+17;    
    V4L2_CID_IRIS_RELATIVE = V4L2_CID_CAMERA_CLASS_BASE+18;    
    V4L2_CID_AUTO_EXPOSURE_BIAS = V4L2_CID_CAMERA_CLASS_BASE+19;    
    V4L2_CID_AUTO_N_PRESET_WHITE_BALANCE = V4L2_CID_CAMERA_CLASS_BASE+20;    

  type
    v4l2_auto_n_preset_white_balance =  Longint;
    Const
      V4L2_WHITE_BALANCE_MANUAL = 0;
      V4L2_WHITE_BALANCE_AUTO = 1;
      V4L2_WHITE_BALANCE_INCANDESCENT = 2;
      V4L2_WHITE_BALANCE_FLUORESCENT = 3;
      V4L2_WHITE_BALANCE_FLUORESCENT_H = 4;
      V4L2_WHITE_BALANCE_HORIZON = 5;
      V4L2_WHITE_BALANCE_DAYLIGHT = 6;
      V4L2_WHITE_BALANCE_FLASH = 7;
      V4L2_WHITE_BALANCE_CLOUDY = 8;
      V4L2_WHITE_BALANCE_SHADE = 9;

    V4L2_CID_WIDE_DYNAMIC_RANGE = V4L2_CID_CAMERA_CLASS_BASE+21;    
    V4L2_CID_IMAGE_STABILIZATION = V4L2_CID_CAMERA_CLASS_BASE+22;    
    V4L2_CID_ISO_SENSITIVITY = V4L2_CID_CAMERA_CLASS_BASE+23;    
    V4L2_CID_ISO_SENSITIVITY_AUTO = V4L2_CID_CAMERA_CLASS_BASE+24;    

  type
    v4l2_iso_sensitivity_auto_type =  Longint;
    Const
      V4L2_ISO_SENSITIVITY_MANUAL = 0;
      V4L2_ISO_SENSITIVITY_AUTO = 1;

    V4L2_CID_EXPOSURE_METERING = V4L2_CID_CAMERA_CLASS_BASE+25;    

  type
    v4l2_exposure_metering =  Longint;
    Const
      V4L2_EXPOSURE_METERING_AVERAGE = 0;
      V4L2_EXPOSURE_METERING_CENTER_WEIGHTED = 1;
      V4L2_EXPOSURE_METERING_SPOT = 2;
      V4L2_EXPOSURE_METERING_MATRIX = 3;

    V4L2_CID_SCENE_MODE = V4L2_CID_CAMERA_CLASS_BASE+26;    

  type
    v4l2_scene_mode =  Longint;
    Const
      V4L2_SCENE_MODE_NONE = 0;
      V4L2_SCENE_MODE_BACKLIGHT = 1;
      V4L2_SCENE_MODE_BEACH_SNOW = 2;
      V4L2_SCENE_MODE_CANDLE_LIGHT = 3;
      V4L2_SCENE_MODE_DAWN_DUSK = 4;
      V4L2_SCENE_MODE_FALL_COLORS = 5;
      V4L2_SCENE_MODE_FIREWORKS = 6;
      V4L2_SCENE_MODE_LANDSCAPE = 7;
      V4L2_SCENE_MODE_NIGHT = 8;
      V4L2_SCENE_MODE_PARTY_INDOOR = 9;
      V4L2_SCENE_MODE_PORTRAIT = 10;
      V4L2_SCENE_MODE_SPORTS = 11;
      V4L2_SCENE_MODE_SUNSET = 12;
      V4L2_SCENE_MODE_TEXT = 13;

    V4L2_CID_3A_LOCK = V4L2_CID_CAMERA_CLASS_BASE+27;    
    V4L2_LOCK_EXPOSURE = 1 shl 0;    
    V4L2_LOCK_WHITE_BALANCE = 1 shl 1;    
    V4L2_LOCK_FOCUS = 1 shl 2;    
    V4L2_CID_AUTO_FOCUS_START = V4L2_CID_CAMERA_CLASS_BASE+28;    
    V4L2_CID_AUTO_FOCUS_STOP = V4L2_CID_CAMERA_CLASS_BASE+29;    
    V4L2_CID_AUTO_FOCUS_STATUS = V4L2_CID_CAMERA_CLASS_BASE+30;    
    V4L2_AUTO_FOCUS_STATUS_IDLE = 0 shl 0;    
    V4L2_AUTO_FOCUS_STATUS_BUSY = 1 shl 0;    
    V4L2_AUTO_FOCUS_STATUS_REACHED = 1 shl 1;    
    V4L2_AUTO_FOCUS_STATUS_FAILED = 1 shl 2;    
    V4L2_CID_AUTO_FOCUS_RANGE = V4L2_CID_CAMERA_CLASS_BASE+31;    

  type
    v4l2_auto_focus_range =  Longint;
    Const
      V4L2_AUTO_FOCUS_RANGE_AUTO = 0;
      V4L2_AUTO_FOCUS_RANGE_NORMAL = 1;
      V4L2_AUTO_FOCUS_RANGE_MACRO = 2;
      V4L2_AUTO_FOCUS_RANGE_INFINITY = 3;

  { FM Modulator class control IDs  }
    V4L2_CID_FM_TX_CLASS_BASE = V4L2_CTRL_CLASS_FM_TX or $900;    
    V4L2_CID_FM_TX_CLASS = V4L2_CTRL_CLASS_FM_TX or 1;    
    V4L2_CID_RDS_TX_DEVIATION = V4L2_CID_FM_TX_CLASS_BASE+1;    
    V4L2_CID_RDS_TX_PI = V4L2_CID_FM_TX_CLASS_BASE+2;    
    V4L2_CID_RDS_TX_PTY = V4L2_CID_FM_TX_CLASS_BASE+3;    
    V4L2_CID_RDS_TX_PS_NAME = V4L2_CID_FM_TX_CLASS_BASE+5;    
    V4L2_CID_RDS_TX_RADIO_TEXT = V4L2_CID_FM_TX_CLASS_BASE+6;    
    V4L2_CID_AUDIO_LIMITER_ENABLED = V4L2_CID_FM_TX_CLASS_BASE+64;    
    V4L2_CID_AUDIO_LIMITER_RELEASE_TIME = V4L2_CID_FM_TX_CLASS_BASE+65;    
    V4L2_CID_AUDIO_LIMITER_DEVIATION = V4L2_CID_FM_TX_CLASS_BASE+66;    
    V4L2_CID_AUDIO_COMPRESSION_ENABLED = V4L2_CID_FM_TX_CLASS_BASE+80;    
    V4L2_CID_AUDIO_COMPRESSION_GAIN = V4L2_CID_FM_TX_CLASS_BASE+81;    
    V4L2_CID_AUDIO_COMPRESSION_THRESHOLD = V4L2_CID_FM_TX_CLASS_BASE+82;    
    V4L2_CID_AUDIO_COMPRESSION_ATTACK_TIME = V4L2_CID_FM_TX_CLASS_BASE+83;    
    V4L2_CID_AUDIO_COMPRESSION_RELEASE_TIME = V4L2_CID_FM_TX_CLASS_BASE+84;    
    V4L2_CID_PILOT_TONE_ENABLED = V4L2_CID_FM_TX_CLASS_BASE+96;    
    V4L2_CID_PILOT_TONE_DEVIATION = V4L2_CID_FM_TX_CLASS_BASE+97;    
    V4L2_CID_PILOT_TONE_FREQUENCY = V4L2_CID_FM_TX_CLASS_BASE+98;    
    V4L2_CID_TUNE_PREEMPHASIS = V4L2_CID_FM_TX_CLASS_BASE+112;    

  type
    v4l2_preemphasis =  Longint;
    Const
      V4L2_PREEMPHASIS_DISABLED = 0;
      V4L2_PREEMPHASIS_50_uS = 1;
      V4L2_PREEMPHASIS_75_uS = 2;

    V4L2_CID_TUNE_POWER_LEVEL = V4L2_CID_FM_TX_CLASS_BASE+113;    
    V4L2_CID_TUNE_ANTENNA_CAPACITOR = V4L2_CID_FM_TX_CLASS_BASE+114;    
  { Flash and privacy (indicator) light controls  }
    V4L2_CID_FLASH_CLASS_BASE = V4L2_CTRL_CLASS_FLASH or $900;    
    V4L2_CID_FLASH_CLASS = V4L2_CTRL_CLASS_FLASH or 1;    
    V4L2_CID_FLASH_LED_MODE = V4L2_CID_FLASH_CLASS_BASE+1;    

  type
    v4l2_flash_led_mode =  Longint;
    Const
      V4L2_FLASH_LED_MODE_NONE = 0;
      V4L2_FLASH_LED_MODE_FLASH = 1;
      V4L2_FLASH_LED_MODE_TORCH = 2;

    V4L2_CID_FLASH_STROBE_SOURCE = V4L2_CID_FLASH_CLASS_BASE+2;    

  type
    v4l2_flash_strobe_source =  Longint;
    Const
      V4L2_FLASH_STROBE_SOURCE_SOFTWARE = 0;
      V4L2_FLASH_STROBE_SOURCE_EXTERNAL = 1;

    V4L2_CID_FLASH_STROBE = V4L2_CID_FLASH_CLASS_BASE+3;    
    V4L2_CID_FLASH_STROBE_STOP = V4L2_CID_FLASH_CLASS_BASE+4;    
    V4L2_CID_FLASH_STROBE_STATUS = V4L2_CID_FLASH_CLASS_BASE+5;    
    V4L2_CID_FLASH_TIMEOUT = V4L2_CID_FLASH_CLASS_BASE+6;    
    V4L2_CID_FLASH_INTENSITY = V4L2_CID_FLASH_CLASS_BASE+7;    
    V4L2_CID_FLASH_TORCH_INTENSITY = V4L2_CID_FLASH_CLASS_BASE+8;    
    V4L2_CID_FLASH_INDICATOR_INTENSITY = V4L2_CID_FLASH_CLASS_BASE+9;    
    V4L2_CID_FLASH_FAULT = V4L2_CID_FLASH_CLASS_BASE+10;    
    V4L2_FLASH_FAULT_OVER_VOLTAGE = 1 shl 0;    
    V4L2_FLASH_FAULT_TIMEOUT = 1 shl 1;    
    V4L2_FLASH_FAULT_OVER_TEMPERATURE = 1 shl 2;    
    V4L2_FLASH_FAULT_SHORT_CIRCUIT = 1 shl 3;    
    V4L2_FLASH_FAULT_OVER_CURRENT = 1 shl 4;    
    V4L2_FLASH_FAULT_INDICATOR = 1 shl 5;    
    V4L2_CID_FLASH_CHARGE = V4L2_CID_FLASH_CLASS_BASE+11;    
    V4L2_CID_FLASH_READY = V4L2_CID_FLASH_CLASS_BASE+12;    
  { JPEG-class control IDs  }
    V4L2_CID_JPEG_CLASS_BASE = V4L2_CTRL_CLASS_JPEG or $900;    
    V4L2_CID_JPEG_CLASS = V4L2_CTRL_CLASS_JPEG or 1;    
    V4L2_CID_JPEG_CHROMA_SUBSAMPLING = V4L2_CID_JPEG_CLASS_BASE+1;    

  type
    v4l2_jpeg_chroma_subsampling =  Longint;
    Const
      V4L2_JPEG_CHROMA_SUBSAMPLING_444 = 0;
      V4L2_JPEG_CHROMA_SUBSAMPLING_422 = 1;
      V4L2_JPEG_CHROMA_SUBSAMPLING_420 = 2;
      V4L2_JPEG_CHROMA_SUBSAMPLING_411 = 3;
      V4L2_JPEG_CHROMA_SUBSAMPLING_410 = 4;
      V4L2_JPEG_CHROMA_SUBSAMPLING_GRAY = 5;

    V4L2_CID_JPEG_RESTART_INTERVAL = V4L2_CID_JPEG_CLASS_BASE+2;    
    V4L2_CID_JPEG_COMPRESSION_QUALITY = V4L2_CID_JPEG_CLASS_BASE+3;    
    V4L2_CID_JPEG_ACTIVE_MARKER = V4L2_CID_JPEG_CLASS_BASE+4;    
    V4L2_JPEG_ACTIVE_MARKER_APP0 = 1 shl 0;    
    V4L2_JPEG_ACTIVE_MARKER_APP1 = 1 shl 1;    
    V4L2_JPEG_ACTIVE_MARKER_COM = 1 shl 16;    
    V4L2_JPEG_ACTIVE_MARKER_DQT = 1 shl 17;    
    V4L2_JPEG_ACTIVE_MARKER_DHT = 1 shl 18;    
  { Image source controls  }
    V4L2_CID_IMAGE_SOURCE_CLASS_BASE = V4L2_CTRL_CLASS_IMAGE_SOURCE or $900;    
    V4L2_CID_IMAGE_SOURCE_CLASS = V4L2_CTRL_CLASS_IMAGE_SOURCE or 1;    
    V4L2_CID_VBLANK = V4L2_CID_IMAGE_SOURCE_CLASS_BASE+1;    
    V4L2_CID_HBLANK = V4L2_CID_IMAGE_SOURCE_CLASS_BASE+2;    
    V4L2_CID_ANALOGUE_GAIN = V4L2_CID_IMAGE_SOURCE_CLASS_BASE+3;    
  { Image processing controls  }
    V4L2_CID_IMAGE_PROC_CLASS_BASE = V4L2_CTRL_CLASS_IMAGE_PROC or $900;    
    V4L2_CID_IMAGE_PROC_CLASS = V4L2_CTRL_CLASS_IMAGE_PROC or 1;    
    V4L2_CID_LINK_FREQ = V4L2_CID_IMAGE_PROC_CLASS_BASE+1;    
    V4L2_CID_PIXEL_RATE = V4L2_CID_IMAGE_PROC_CLASS_BASE+2;    
    V4L2_CID_TEST_PATTERN = V4L2_CID_IMAGE_PROC_CLASS_BASE+3;    
  {  DV-class control IDs defined by V4L2  }
    V4L2_CID_DV_CLASS_BASE = V4L2_CTRL_CLASS_DV or $900;    
    V4L2_CID_DV_CLASS = V4L2_CTRL_CLASS_DV or 1;    
    V4L2_CID_DV_TX_HOTPLUG = V4L2_CID_DV_CLASS_BASE+1;    
    V4L2_CID_DV_TX_RXSENSE = V4L2_CID_DV_CLASS_BASE+2;    
    V4L2_CID_DV_TX_EDID_PRESENT = V4L2_CID_DV_CLASS_BASE+3;    
    V4L2_CID_DV_TX_MODE = V4L2_CID_DV_CLASS_BASE+4;    

  type
    v4l2_dv_tx_mode =  Longint;
    Const
      V4L2_DV_TX_MODE_DVI_D = 0;
      V4L2_DV_TX_MODE_HDMI = 1;

    V4L2_CID_DV_TX_RGB_RANGE = V4L2_CID_DV_CLASS_BASE+5;    

  type
    v4l2_dv_rgb_range =  Longint;
    Const
      V4L2_DV_RGB_RANGE_AUTO = 0;
      V4L2_DV_RGB_RANGE_LIMITED = 1;
      V4L2_DV_RGB_RANGE_FULL = 2;

    V4L2_CID_DV_RX_POWER_PRESENT = V4L2_CID_DV_CLASS_BASE+100;    
    V4L2_CID_DV_RX_RGB_RANGE = V4L2_CID_DV_CLASS_BASE+101;    
    V4L2_CID_FM_RX_CLASS_BASE = V4L2_CTRL_CLASS_FM_RX or $900;    
    V4L2_CID_FM_RX_CLASS = V4L2_CTRL_CLASS_FM_RX or 1;    
    V4L2_CID_TUNE_DEEMPHASIS = V4L2_CID_FM_RX_CLASS_BASE+1;    

  type
    v4l2_deemphasis =  Longint;
    Const
      V4L2_DEEMPHASIS_DISABLED = V4L2_PREEMPHASIS_DISABLED;
      V4L2_DEEMPHASIS_50_uS = V4L2_PREEMPHASIS_50_uS;
      V4L2_DEEMPHASIS_75_uS = V4L2_PREEMPHASIS_75_uS;

    V4L2_CID_RDS_RECEPTION = V4L2_CID_FM_RX_CLASS_BASE+2;    
{$endif}
  //__LINUX_V4L2_CONTROLS_H

  {
   * Common stuff for both V4L1 and V4L2
   * Moved from videodev.h
    }

  const
    VIDEO_MAX_FRAME = 32;    
    VIDEO_MAX_PLANES = 8;    
  {
   *	M I S C E L L A N E O U S
    }
  {  Four-character-code (FOURCC)  }
//#define v4l2_fourcc(a, b, c, d)\
//	((__u32)(a) | ((__u32)(b) << 8) | ((__u32)(c) << 16) | ((__u32)(d) << 24))

  {
   *	E N U M S
    }
  { driver can choose from none,
  					 top, bottom, interlaced
  					 depending on whatever it thinks
  					 is approximate ...  }
  { this device has no fields ...  }
  { top field only  }
  { bottom field only  }
  { both fields interlaced  }
  { both fields sequential into one
  					 buffer, top-bottom order  }
  { same as above + bottom-top order  }
  { both fields alternating into
  					 separate buffers  }
  { both fields interlaced, top field
  					 first and the top field is
  					 transmitted first  }
  { both fields interlaced, top field
  					 first and the bottom field is
  					 transmitted first  }

  type
    v4l2_field =  Longint;
    Const
      V4L2_FIELD_ANY = 0;
      V4L2_FIELD_NONE = 1;
      V4L2_FIELD_TOP = 2;
      V4L2_FIELD_BOTTOM = 3;
      V4L2_FIELD_INTERLACED = 4;
      V4L2_FIELD_SEQ_TB = 5;
      V4L2_FIELD_SEQ_BT = 6;
      V4L2_FIELD_ALTERNATE = 7;
      V4L2_FIELD_INTERLACED_TB = 8;
      V4L2_FIELD_INTERLACED_BT = 9;

  {
  #define V4L2_FIELD_HAS_TOP(field)	\
  	((field) == V4L2_FIELD_TOP 	||\
  	 (field) == V4L2_FIELD_INTERLACED ||\
  	 (field) == V4L2_FIELD_INTERLACED_TB ||\
  	 (field) == V4L2_FIELD_INTERLACED_BT ||\
  	 (field) == V4L2_FIELD_SEQ_TB	||\
  	 (field) == V4L2_FIELD_SEQ_BT)
  #define V4L2_FIELD_HAS_BOTTOM(field)	\
  	((field) == V4L2_FIELD_BOTTOM 	||\
  	 (field) == V4L2_FIELD_INTERLACED ||\
  	 (field) == V4L2_FIELD_INTERLACED_TB ||\
  	 (field) == V4L2_FIELD_INTERLACED_BT ||\
  	 (field) == V4L2_FIELD_SEQ_TB	||\
  	 (field) == V4L2_FIELD_SEQ_BT)
  #define V4L2_FIELD_HAS_BOTH(field)	\
  	((field) == V4L2_FIELD_INTERLACED ||\
  	 (field) == V4L2_FIELD_INTERLACED_TB ||\
  	 (field) == V4L2_FIELD_INTERLACED_BT ||\
  	 (field) == V4L2_FIELD_SEQ_TB ||\
  	 (field) == V4L2_FIELD_SEQ_BT)
   }
{$if 1}
    { Experimental  }
{$endif}
  { Deprecated, do not use  }

  type
    v4l2_buf_type =  Longint;
    Const
      V4L2_BUF_TYPE_VIDEO_CAPTURE = 1;
      V4L2_BUF_TYPE_VIDEO_OUTPUT = 2;
      V4L2_BUF_TYPE_VIDEO_OVERLAY = 3;
      V4L2_BUF_TYPE_VBI_CAPTURE = 4;
      V4L2_BUF_TYPE_VBI_OUTPUT = 5;
      V4L2_BUF_TYPE_SLICED_VBI_CAPTURE = 6;
      V4L2_BUF_TYPE_SLICED_VBI_OUTPUT = 7;
        V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY = 8;
      V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE = 9;
      V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE = 10;
      V4L2_BUF_TYPE_PRIVATE = $80;

  {
  #define V4L2_TYPE_IS_MULTIPLANAR(type)			\
  	((type) == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE	\
  	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
  #define V4L2_TYPE_IS_OUTPUT(type)				\
  	((type) == V4L2_BUF_TYPE_VIDEO_OUTPUT			\
  	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE		\
  	 || (type) == V4L2_BUF_TYPE_VIDEO_OVERLAY		\
  	 || (type) == V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY	\
  	 || (type) == V4L2_BUF_TYPE_VBI_OUTPUT			\
  	 || (type) == V4L2_BUF_TYPE_SLICED_VBI_OUTPUT)
   }

  type
    v4l2_tuner_type =  Longint;
    Const
      V4L2_TUNER_RADIO = 1;
      V4L2_TUNER_ANALOG_TV = 2;
      V4L2_TUNER_DIGITAL_TV = 3;


  type
    v4l2_memory =  Longint;
    Const
      V4L2_MEMORY_MMAP = 1;
      V4L2_MEMORY_USERPTR = 2;
      V4L2_MEMORY_OVERLAY = 3;
      V4L2_MEMORY_DMABUF = 4;

  { see also http://vektor.theorem.ca/graphics/ycbcr/  }
  { ITU-R 601 -- broadcast NTSC/PAL  }
  { 1125-Line (US) HDTV  }
  { HD and modern captures.  }
  { broken BT878 extents (601, luma range 16-253 instead of 16-235)  }
  { These should be useful.  Assume 601 extents.  }
  { I know there will be cameras that send this.  So, this is
  	 * unspecified chromaticities and full 0-255 on each of the
  	 * Y'CbCr components
  	  }
  { For RGB colourspaces, this is probably a good start.  }

  type
    v4l2_colorspace =  Longint;
    Const
      V4L2_COLORSPACE_SMPTE170M = 1;
      V4L2_COLORSPACE_SMPTE240M = 2;
      V4L2_COLORSPACE_REC709 = 3;
      V4L2_COLORSPACE_BT878 = 4;
      V4L2_COLORSPACE_470_SYSTEM_M = 5;
      V4L2_COLORSPACE_470_SYSTEM_BG = 6;
      V4L2_COLORSPACE_JPEG = 7;
      V4L2_COLORSPACE_SRGB = 8;

  { not initialized  }

  type
    v4l2_priority =  Longint;
    Const
      V4L2_PRIORITY_UNSET = 0;
      V4L2_PRIORITY_BACKGROUND = 1;
      V4L2_PRIORITY_INTERACTIVE = 2;
      V4L2_PRIORITY_RECORD = 3;
      V4L2_PRIORITY_DEFAULT = V4L2_PRIORITY_INTERACTIVE;


  type
    Pv4l2_rect = ^v4l2_rect;
    v4l2_rect = record
        left : __s32;
        top : __s32;
        width : __s32;
        height : __s32;
      end;

    Pv4l2_fract = ^v4l2_fract;
    v4l2_fract = record
        numerator : __u32;
        denominator : __u32;
      end;

  {*
    * struct v4l2_capability - Describes V4L2 device caps returned by VIDIOC_QUERYCAP
    *
    * @driver:	   name of the driver module (e.g. "bttv")
    * @card:	   name of the card (e.g. "Hauppauge WinTV")
    * @bus_info:	   name of the bus (e.g. "PCI:" + pci_name(pci_dev) )
    * @version:	   KERNEL_VERSION
    * @capabilities: capabilities of the physical device as a whole
    * @device_caps:  capabilities accessed via this particular device (node)
    * @reserved:	   reserved fields for future extensions
     }
    Pv4l2_capability = ^v4l2_capability;
    v4l2_capability = record
        driver : array[0..15] of __u8;
        card : array[0..31] of __u8;
        bus_info : array[0..31] of __u8;
        version : __u32;
        capabilities : __u32;
        device_caps : __u32;
        reserved : array[0..2] of __u32;
      end;

  { Values for 'capabilities' field  }
  { Is a video capture device  }

  const
    V4L2_CAP_VIDEO_CAPTURE = $00000001;    
  { Is a video output device  }
    V4L2_CAP_VIDEO_OUTPUT = $00000002;    
  { Can do video overlay  }
    V4L2_CAP_VIDEO_OVERLAY = $00000004;    
  { Is a raw VBI capture device  }
    V4L2_CAP_VBI_CAPTURE = $00000010;    
  { Is a raw VBI output device  }
    V4L2_CAP_VBI_OUTPUT = $00000020;    
  { Is a sliced VBI capture device  }
    V4L2_CAP_SLICED_VBI_CAPTURE = $00000040;    
  { Is a sliced VBI output device  }
    V4L2_CAP_SLICED_VBI_OUTPUT = $00000080;    
  { RDS data capture  }
    V4L2_CAP_RDS_CAPTURE = $00000100;    
  { Can do video output overlay  }
    V4L2_CAP_VIDEO_OUTPUT_OVERLAY = $00000200;    
  { Can do hardware frequency seek   }
    V4L2_CAP_HW_FREQ_SEEK = $00000400;    
  { Is an RDS encoder  }
    V4L2_CAP_RDS_OUTPUT = $00000800;    
  { Is a video capture device that supports multiplanar formats  }
    V4L2_CAP_VIDEO_CAPTURE_MPLANE = $00001000;    
  { Is a video output device that supports multiplanar formats  }
    V4L2_CAP_VIDEO_OUTPUT_MPLANE = $00002000;    
  { Is a video mem-to-mem device that supports multiplanar formats  }
    V4L2_CAP_VIDEO_M2M_MPLANE = $00004000;    
  { Is a video mem-to-mem device  }
    V4L2_CAP_VIDEO_M2M = $00008000;    
  { has a tuner  }
    V4L2_CAP_TUNER = $00010000;    
  { has audio support  }
    V4L2_CAP_AUDIO = $00020000;    
  { is a radio device  }
    V4L2_CAP_RADIO = $00040000;    
  { has a modulator  }
    V4L2_CAP_MODULATOR = $00080000;    
  { read/write systemcalls  }
    V4L2_CAP_READWRITE = $01000000;    
  { async I/O  }
    V4L2_CAP_ASYNCIO = $02000000;    
  { streaming I/O ioctls  }
    V4L2_CAP_STREAMING = $04000000;    
  { sets device capabilities field  }
    V4L2_CAP_DEVICE_CAPS = $80000000;    
  {
   *	V I D E O   I M A G E   F O R M A T
    }
  { enum v4l2_field  }
  { for padding, zero if unused  }
  { enum v4l2_colorspace  }
  { private data, depends on pixelformat  }

  type
    Pv4l2_pix_format = ^v4l2_pix_format;
    v4l2_pix_format = record
        width : __u32;
        height : __u32;
        pixelformat : __u32;
        field : __u32;
        bytesperline : __u32;
        sizeimage : __u32;
        colorspace : __u32;
        priv : __u32;
      end;

{      Pixel format         FOURCC                          depth  Description  }
const
{ RGB formats }
  V4L2_PIX_FMT_RGB332  = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('1') shl 24); {  8  RGB-3-3-2     *}
  V4L2_PIX_FMT_RGB444  = (Ord('R')) or (Ord('4') shl 8) or (Ord('4') shl 16) or (Ord('4') shl 24); { 16  xxxxrrrr ggggbbbb *}
  V4L2_PIX_FMT_RGB555  = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('O') shl 24); { 16  RGB-5-5-5     *}
  V4L2_PIX_FMT_RGB565  = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('P') shl 24); { 16  RGB-5-6-5     *}
  V4L2_PIX_FMT_RGB555X = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('Q') shl 24); { 16  RGB-5-5-5 BE  *}
  V4L2_PIX_FMT_RGB565X = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('R') shl 24); { 16  RGB-5-6-5 BE  *}
  V4L2_PIX_FMT_BGR666  = (Ord('B')) or (Ord('G') shl 8) or (Ord('R') shl 16) or (Ord('H') shl 24); { 18  BGR-6-6-6     *}
  V4L2_PIX_FMT_BGR24   = (Ord('B')) or (Ord('G') shl 8) or (Ord('R') shl 16) or (Ord('3') shl 24); { 24  BGR-8-8-8     *}
  V4L2_PIX_FMT_RGB24   = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('3') shl 24); { 24  RGB-8-8-8     *}
  V4L2_PIX_FMT_BGR32   = (Ord('B')) or (Ord('G') shl 8) or (Ord('R') shl 16) or (Ord('4') shl 24); { 32  BGR-8-8-8-8   *}
  V4L2_PIX_FMT_RGB32   = (Ord('R')) or (Ord('G') shl 8) or (Ord('B') shl 16) or (Ord('4') shl 24); { 32  RGB-8-8-8-8   *}

{ Grey formats }
  V4L2_PIX_FMT_GREY    = (Ord('G')) or (Ord('R') shl 8) or (Ord('E') shl 16) or (Ord('Y') shl 24); {  8  Greyscale     *}
  V4L2_PIX_FMT_Y4      = (Ord('Y')) or (Ord('0') shl 8) or (Ord('4') shl 16) or (Ord(' ') shl 24); {  4  Greyscale     *}
  V4L2_PIX_FMT_Y6      = (Ord('Y')) or (Ord('0') shl 8) or (Ord('6') shl 16) or (Ord(' ') shl 24); {  6  Greyscale     *}
  V4L2_PIX_FMT_Y10     = (Ord('Y')) or (Ord('1') shl 8) or (Ord('0') shl 16) or (Ord(' ') shl 24); { 10  Greyscale     *}
  V4L2_PIX_FMT_Y12     = (Ord('Y')) or (Ord('1') shl 8) or (Ord('2') shl 16) or (Ord(' ') shl 24); { 12  Greyscale     *}
  V4L2_PIX_FMT_Y16     = (Ord('Y')) or (Ord('1') shl 8) or (Ord('6') shl 16) or (Ord(' ') shl 24); { 16  Greyscale     *}

{ Grey bit-packed formats }
  V4L2_PIX_FMT_Y10BPACK    = (Ord('Y')) or (Ord('1') shl 8) or (Ord('0') shl 16) or (Ord('B') shl 24); { 10  Greyscale bit-packed *}

{ Palette formats }
  V4L2_PIX_FMT_PAL8    = (Ord('P')) or (Ord('A') shl 8) or (Ord('L') shl 16) or (Ord('8') shl 24); {  8  8-bit palette *}

{ Chrominance formats }
  V4L2_PIX_FMT_UV8     = (Ord('U')) or (Ord('V') shl 8) or (Ord('8') shl 16) or (Ord(' ') shl 24); {  8  UV 4:4 *}

{ Luminance+Chrominance formats }
  V4L2_PIX_FMT_YVU410  = (Ord('Y')) or (Ord('V') shl 8) or (Ord('U') shl 16) or (Ord('9') shl 24); {  9  YVU 4:1:0     *}
  V4L2_PIX_FMT_YVU420  = (Ord('Y')) or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  YVU 4:2:0     *}
  V4L2_PIX_FMT_YUYV    = (Ord('Y')) or (Ord('U') shl 8) or (Ord('Y') shl 16) or (Ord('V') shl 24); { 16  YUV 4:2:2     *}
  V4L2_PIX_FMT_YYUV    = (Ord('Y')) or (Ord('Y') shl 8) or (Ord('U') shl 16) or (Ord('V') shl 24); { 16  YUV 4:2:2     *}
  V4L2_PIX_FMT_YVYU    = (Ord('Y')) or (Ord('V') shl 8) or (Ord('Y') shl 16) or (Ord('U') shl 24); { 16 YVU 4:2:2 *}
  V4L2_PIX_FMT_UYVY    = (Ord('U')) or (Ord('Y') shl 8) or (Ord('V') shl 16) or (Ord('Y') shl 24); { 16  YUV 4:2:2     *}
  V4L2_PIX_FMT_VYUY    = (Ord('V')) or (Ord('Y') shl 8) or (Ord('U') shl 16) or (Ord('Y') shl 24); { 16  YUV 4:2:2     *}
  V4L2_PIX_FMT_YUV422P = (Ord('4')) or (Ord('2') shl 8) or (Ord('2') shl 16) or (Ord('P') shl 24); { 16  YVU422 planar *}
  V4L2_PIX_FMT_YUV411P = (Ord('4')) or (Ord('1') shl 8) or (Ord('1') shl 16) or (Ord('P') shl 24); { 16  YVU411 planar *}
  V4L2_PIX_FMT_Y41P    = (Ord('Y')) or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('P') shl 24); { 12  YUV 4:1:1     *}
  V4L2_PIX_FMT_YUV444  = (Ord('Y')) or (Ord('4') shl 8) or (Ord('4') shl 16) or (Ord('4') shl 24); { 16  xxxxyyyy uuuuvvvv *}
  V4L2_PIX_FMT_YUV555  = (Ord('Y')) or (Ord('U') shl 8) or (Ord('V') shl 16) or (Ord('O') shl 24); { 16  YUV-5-5-5     *}
  V4L2_PIX_FMT_YUV565  = (Ord('Y')) or (Ord('U') shl 8) or (Ord('V') shl 16) or (Ord('P') shl 24); { 16  YUV-5-6-5     *}
  V4L2_PIX_FMT_YUV32   = (Ord('Y')) or (Ord('U') shl 8) or (Ord('V') shl 16) or (Ord('4') shl 24); { 32  YUV-8-8-8-8   *}
  V4L2_PIX_FMT_YUV410  = (Ord('Y')) or (Ord('U') shl 8) or (Ord('V') shl 16) or (Ord('9') shl 24); {  9  YUV 4:1:0     *}
  V4L2_PIX_FMT_YUV420  = (Ord('Y')) or (Ord('U') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  YUV 4:2:0     *}
  V4L2_PIX_FMT_HI240   = (Ord('H')) or (Ord('I') shl 8) or (Ord('2') shl 16) or (Ord('4') shl 24); {  8  8-bit color   *}
  V4L2_PIX_FMT_HM12    = (Ord('H')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); {  8  YUV 4:2:0 16x16 macroblocks *}
  V4L2_PIX_FMT_M420    = (Ord('M')) or (Ord('4') shl 8) or (Ord('2') shl 16) or (Ord('0') shl 24); { 12  YUV 4:2:0 2 lines y, 1 line uv interleaved *}

{ two planes -- one Y, one Cr + Cb interleaved  }
  V4L2_PIX_FMT_NV12    = (Ord('N')) or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  Y/CbCr 4:2:0  *}
  V4L2_PIX_FMT_NV21    = (Ord('N')) or (Ord('V') shl 8) or (Ord('2') shl 16) or (Ord('1') shl 24); { 12  Y/CrCb 4:2:0  *}
  V4L2_PIX_FMT_NV16    = (Ord('N')) or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); { 16  Y/CbCr 4:2:2  *}
  V4L2_PIX_FMT_NV61    = (Ord('N')) or (Ord('V') shl 8) or (Ord('6') shl 16) or (Ord('1') shl 24); { 16  Y/CrCb 4:2:2  *}
  V4L2_PIX_FMT_NV24    = (Ord('N')) or (Ord('V') shl 8) or (Ord('2') shl 16) or (Ord('4') shl 24); { 24  Y/CbCr 4:4:4  *}
  V4L2_PIX_FMT_NV42    = (Ord('N')) or (Ord('V') shl 8) or (Ord('4') shl 16) or (Ord('2') shl 24); { 24  Y/CrCb 4:4:4  *}

{ two non contiguous planes - one Y, one Cr + Cb interleaved  }
  V4L2_PIX_FMT_NV12M   = (Ord('N')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  Y/CbCr 4:2:0  *}
  V4L2_PIX_FMT_NV21M   = (Ord('N')) or (Ord('M') shl 8) or (Ord('2') shl 16) or (Ord('1') shl 24); { 21  Y/CrCb 4:2:0  *}
  V4L2_PIX_FMT_NV16M   = (Ord('N')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); { 16  Y/CbCr 4:2:2  *}
  V4L2_PIX_FMT_NV61M   = (Ord('N')) or (Ord('M') shl 8) or (Ord('6') shl 16) or (Ord('1') shl 24); { 16  Y/CrCb 4:2:2  *}
  V4L2_PIX_FMT_NV12MT  = (Ord('T')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  Y/CbCr 4:2:0 64x32 macroblocks *}
  V4L2_PIX_FMT_NV12MT_16X16 = (Ord('V')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  Y/CbCr 4:2:0 16x16 macroblocks *}

{ three non contiguous planes - Y, Cb, Cr }
  V4L2_PIX_FMT_YUV420M = (Ord('Y')) or (Ord('M') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  YUV420 planar *}
  V4L2_PIX_FMT_YVU420M = (Ord('Y')) or (Ord('M') shl 8) or (Ord('2') shl 16) or (Ord('1') shl 24); { 12  YVU420 planar *}

{ Bayer formats - see http://www.siliconimaging.com/RGB%20Bayer.htm }
  V4L2_PIX_FMT_SBGGR8  = (Ord('B')) or (Ord('A') shl 8) or (Ord('8') shl 16) or (Ord('1') shl 24); {  8  BGBG.. GRGR.. *}
  V4L2_PIX_FMT_SGBRG8  = (Ord('G')) or (Ord('B') shl 8) or (Ord('R') shl 16) or (Ord('G') shl 24); {  8  GBGB.. RGRG.. *}
  V4L2_PIX_FMT_SGRBG8  = (Ord('G')) or (Ord('R') shl 8) or (Ord('B') shl 16) or (Ord('G') shl 24); {  8  GRGR.. BGBG.. *}
  V4L2_PIX_FMT_SRGGB8  = (Ord('R')) or (Ord('G') shl 8) or (Ord('G') shl 16) or (Ord('B') shl 24); {  8  RGRG.. GBGB.. *}
  V4L2_PIX_FMT_SBGGR10 = (Ord('B')) or (Ord('G') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { 10  BGBG.. GRGR.. *}
  V4L2_PIX_FMT_SGBRG10 = (Ord('G')) or (Ord('B') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { 10  GBGB.. RGRG.. *}
  V4L2_PIX_FMT_SGRBG10 = (Ord('B')) or (Ord('A') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { 10  GRGR.. BGBG.. *}
  V4L2_PIX_FMT_SRGGB10 = (Ord('R')) or (Ord('G') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { 10  RGRG.. GBGB.. *}
  V4L2_PIX_FMT_SBGGR12 = (Ord('B')) or (Ord('G') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  BGBG.. GRGR.. *}
  V4L2_PIX_FMT_SGBRG12 = (Ord('G')) or (Ord('B') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  GBGB.. RGRG.. *}
  V4L2_PIX_FMT_SGRBG12 = (Ord('B')) or (Ord('A') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  GRGR.. BGBG.. *}
  V4L2_PIX_FMT_SRGGB12 = (Ord('R')) or (Ord('G') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); { 12  RGRG.. GBGB.. *}
        { 10bit raw bayer a-law compressed to 8 bits }
  V4L2_PIX_FMT_SBGGR10ALAW8 = (Ord('a')) or (Ord('B') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SGBRG10ALAW8 = (Ord('a')) or (Ord('G') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SGRBG10ALAW8 = (Ord('a')) or (Ord('g') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SRGGB10ALAW8 = (Ord('a')) or (Ord('R') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
        { 10bit raw bayer DPCM compressed to 8 bits }
  V4L2_PIX_FMT_SBGGR10DPCM8 = (Ord('b')) or (Ord('B') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SGBRG10DPCM8 = (Ord('b')) or (Ord('G') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
  V4L2_PIX_FMT_SGRBG10DPCM8 = (Ord('B')) or (Ord('D') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24);
  V4L2_PIX_FMT_SRGGB10DPCM8 = (Ord('b')) or (Ord('R') shl 8) or (Ord('A') shl 16) or (Ord('8') shl 24);
        {
         * 10bit raw bayer, expanded to 16 bits
         * xxxxrrrrrrrrrrxxxxgggggggggg xxxxggggggggggxxxxbbbbbbbbbb...
         }
  V4L2_PIX_FMT_SBGGR16 = (Ord('B')) or (Ord('Y') shl 8) or (Ord('R') shl 16) or (Ord('2') shl 24); { 16  BGBG.. GRGR.. *}

{ compressed formats }
  V4L2_PIX_FMT_MJPEG    = (Ord('M')) or (Ord('J') shl 8) or (Ord('P') shl 16) or (Ord('G') shl 24); { Motion-JPEG   *}
  V4L2_PIX_FMT_JPEG     = (Ord('J')) or (Ord('P') shl 8) or (Ord('E') shl 16) or (Ord('G') shl 24); { JFIF JPEG     *}
  V4L2_PIX_FMT_DV       = (Ord('d')) or (Ord('v') shl 8) or (Ord('s') shl 16) or (Ord('d') shl 24); { 1394          *}
  V4L2_PIX_FMT_MPEG     = (Ord('M')) or (Ord('P') shl 8) or (Ord('E') shl 16) or (Ord('G') shl 24); { MPEG-1/2/4 Multiplexed *}
  V4L2_PIX_FMT_H264     = (Ord('H')) or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('4') shl 24); { H264 with start codes *}
  V4L2_PIX_FMT_H264_NO_SC = (Ord('A')) or (Ord('V') shl 8) or (Ord('C') shl 16) or (Ord('1') shl 24); { H264 without start codes *}
  V4L2_PIX_FMT_H264_MVC = (Ord('M')) or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('4') shl 24); { H264 MVC *}
  V4L2_PIX_FMT_H263     = (Ord('H')) or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('3') shl 24); { H263          *}
  V4L2_PIX_FMT_MPEG1    = (Ord('M')) or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('1') shl 24); { MPEG-1 ES     *}
  V4L2_PIX_FMT_MPEG2    = (Ord('M')) or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('2') shl 24); { MPEG-2 ES     *}
  V4L2_PIX_FMT_MPEG4    = (Ord('M')) or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('4') shl 24); { MPEG-4 part 2 ES *}
  V4L2_PIX_FMT_XVID     = (Ord('X')) or (Ord('V') shl 8) or (Ord('I') shl 16) or (Ord('D') shl 24); { Xvid           *}
  V4L2_PIX_FMT_VC1_ANNEX_G = (Ord('V')) or (Ord('C') shl 8) or (Ord('1') shl 16) or (Ord('G') shl 24); { SMPTE 421M Annex G compliant stream *}
  V4L2_PIX_FMT_VC1_ANNEX_L = (Ord('V')) or (Ord('C') shl 8) or (Ord('1') shl 16) or (Ord('L') shl 24); { SMPTE 421M Annex L compliant stream *}
  V4L2_PIX_FMT_VP8      = (Ord('V')) or (Ord('P') shl 8) or (Ord('8') shl 16) or (Ord('0') shl 24); { VP8 *}

{  Vendor-specific formats   }
  V4L2_PIX_FMT_CPIA1    = (Ord('C')) or (Ord('P') shl 8) or (Ord('I') shl 16) or (Ord('A') shl 24); { cpia1 YUV *}
  V4L2_PIX_FMT_WNVA     = (Ord('W')) or (Ord('N') shl 8) or (Ord('V') shl 16) or (Ord('A') shl 24); { Winnov hw compress *}
  V4L2_PIX_FMT_SN9C10X  = (Ord('S')) or (Ord('9') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { SN9C10x compression *}
  V4L2_PIX_FMT_SN9C20X_I420 = (Ord('S')) or (Ord('9') shl 8) or (Ord('2') shl 16) or (Ord('0') shl 24); { SN9C20x YUV 4:2:0 *}
  V4L2_PIX_FMT_PWC1     = (Ord('P')) or (Ord('W') shl 8) or (Ord('C') shl 16) or (Ord('1') shl 24); { pwc older webcam *}
  V4L2_PIX_FMT_PWC2     = (Ord('P')) or (Ord('W') shl 8) or (Ord('C') shl 16) or (Ord('2') shl 24); { pwc newer webcam *}
  V4L2_PIX_FMT_ET61X251 = (Ord('E')) or (Ord('6') shl 8) or (Ord('2') shl 16) or (Ord('5') shl 24); { ET61X251 compression *}
  V4L2_PIX_FMT_SPCA501  = (Ord('S')) or (Ord('5') shl 8) or (Ord('0') shl 16) or (Ord('1') shl 24); { YUYV per line *}
  V4L2_PIX_FMT_SPCA505  = (Ord('S')) or (Ord('5') shl 8) or (Ord('0') shl 16) or (Ord('5') shl 24); { YYUV per line *}
  V4L2_PIX_FMT_SPCA508  = (Ord('S')) or (Ord('5') shl 8) or (Ord('0') shl 16) or (Ord('8') shl 24); { YUVY per line *}
  V4L2_PIX_FMT_SPCA561  = (Ord('S')) or (Ord('5') shl 8) or (Ord('6') shl 16) or (Ord('1') shl 24); { compressed GBRG bayer *}
  V4L2_PIX_FMT_PAC207   = (Ord('P')) or (Ord('2') shl 8) or (Ord('0') shl 16) or (Ord('7') shl 24); { compressed BGGR bayer *}
  V4L2_PIX_FMT_MR97310A = (Ord('M')) or (Ord('3') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); { compressed BGGR bayer *}
  V4L2_PIX_FMT_JL2005BCD = (Ord('J')) or (Ord('L') shl 8) or (Ord('2') shl 16) or (Ord('0') shl 24); { compressed RGGB bayer *}
  V4L2_PIX_FMT_SN9C2028 = (Ord('S')) or (Ord('O') shl 8) or (Ord('N') shl 16) or (Ord('X') shl 24); { compressed GBRG bayer *}
  V4L2_PIX_FMT_SQ905C   = (Ord('9')) or (Ord('0') shl 8) or (Ord('5') shl 16) or (Ord('C') shl 24); { compressed RGGB bayer *}
  V4L2_PIX_FMT_PJPG     = (Ord('P')) or (Ord('J') shl 8) or (Ord('P') shl 16) or (Ord('G') shl 24); { Pixart 73xx JPEG *}
  V4L2_PIX_FMT_OV511    = (Ord('O')) or (Ord('5') shl 8) or (Ord('1') shl 16) or (Ord('1') shl 24); { ov511 JPEG *}
  V4L2_PIX_FMT_OV518    = (Ord('O')) or (Ord('5') shl 8) or (Ord('1') shl 16) or (Ord('8') shl 24); { ov518 JPEG *}
  V4L2_PIX_FMT_STV0680  = (Ord('S')) or (Ord('6') shl 8) or (Ord('8') shl 16) or (Ord('0') shl 24); { stv0680 bayer *}
  V4L2_PIX_FMT_TM6000   = (Ord('T')) or (Ord('M') shl 8) or (Ord('6') shl 16) or (Ord('0') shl 24); { tm5600/tm60x0 *}
  V4L2_PIX_FMT_CIT_YYVYUY = (Ord('C')) or (Ord('I') shl 8) or (Ord('T') shl 16) or (Ord('V') shl 24); { one line of Y then 1 line of VYUY *}
  V4L2_PIX_FMT_KONICA420  = (Ord('K')) or (Ord('O') shl 8) or (Ord('N') shl 16) or (Ord('I') shl 24); { YUV420 planar in blocks of 256 pixels *}
  V4L2_PIX_FMT_JPGL       = (Ord('J')) or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('L') shl 24); { JPEG-Lite *}
  V4L2_PIX_FMT_SE401      = (Ord('S')) or (Ord('4') shl 8) or (Ord('0') shl 16) or (Ord('1') shl 24); { se401 janggu compressed rgb *}
  V4L2_PIX_FMT_S5C_UYVY_JPG = (Ord('S')) or (Ord('5') shl 8) or (Ord('C') shl 16) or (Ord('I') shl 24); { S5C73M3 interleaved UYVY/JPEG *}

  {
   *	F O R M A T   E N U M E R A T I O N
    }
  { Format number       }
  { enum v4l2_buf_type  }
  { Description string  }
  { Format fourcc       }

  type
    Pv4l2_fmtdesc = ^v4l2_fmtdesc;
    v4l2_fmtdesc = record
        index : __u32;
        _type : __u32;
        flags : __u32;
        description : array[0..31] of __u8;
        pixelformat : __u32;
        reserved : array[0..3] of __u32;
      end;


  const
    V4L2_FMT_FLAG_COMPRESSED = $0001;    
    V4L2_FMT_FLAG_EMULATED = $0002;    
{$if 1}
  { Experimental Frame Size and frame rate enumeration  }
  {
   *	F R A M E   S I Z E   E N U M E R A T I O N
    }

  type
    v4l2_frmsizetypes =  Longint;
    Const
      V4L2_FRMSIZE_TYPE_DISCRETE = 1;
      V4L2_FRMSIZE_TYPE_CONTINUOUS = 2;
      V4L2_FRMSIZE_TYPE_STEPWISE = 3;

  { Frame width [pixel]  }
  { Frame height [pixel]  }

  type
    Pv4l2_frmsize_discrete = ^v4l2_frmsize_discrete;
    v4l2_frmsize_discrete = record
        width : __u32;
        height : __u32;
      end;

  { Minimum frame width [pixel]  }
  { Maximum frame width [pixel]  }
  { Frame width step size [pixel]  }
  { Minimum frame height [pixel]  }
  { Maximum frame height [pixel]  }
  { Frame height step size [pixel]  }
    Pv4l2_frmsize_stepwise = ^v4l2_frmsize_stepwise;
    v4l2_frmsize_stepwise = record
        min_width : __u32;
        max_width : __u32;
        step_width : __u32;
        min_height : __u32;
        max_height : __u32;
        step_height : __u32;
      end;

  { Frame size number  }
  { Pixel format  }
  { Frame size type the device supports.  }
  { Frame size  }
  { Reserved space for future use  }
    Pv4l2_frmsizeenum = ^v4l2_frmsizeenum;
    v4l2_frmsizeenum = record
        index : __u32;
        pixel_format : __u32;
        _type : __u32;
        u : record
            case longint of
              0 : ( discrete : v4l2_frmsize_discrete );
              1 : ( stepwise : v4l2_frmsize_stepwise );
            end;
        reserved : array[0..1] of __u32;
      end;

  {
   *	F R A M E   R A T E   E N U M E R A T I O N
    }
    v4l2_frmivaltypes =  Longint;
    Const
      V4L2_FRMIVAL_TYPE_DISCRETE = 1;
      V4L2_FRMIVAL_TYPE_CONTINUOUS = 2;
      V4L2_FRMIVAL_TYPE_STEPWISE = 3;

  { Minimum frame interval [s]  }
  { Maximum frame interval [s]  }
  { Frame interval step size [s]  }

  type
    Pv4l2_frmival_stepwise = ^v4l2_frmival_stepwise;
    v4l2_frmival_stepwise = record
        min : v4l2_fract;
        max : v4l2_fract;
        step : v4l2_fract;
      end;

  { Frame format index  }
  { Pixel format  }
  { Frame width  }
  { Frame height  }
  { Frame interval type the device supports.  }
  { Frame interval  }
  { Reserved space for future use  }
    Pv4l2_frmivalenum = ^v4l2_frmivalenum;
    v4l2_frmivalenum = record
        index : __u32;
        pixel_format : __u32;
        width : __u32;
        height : __u32;
        _type : __u32;
        u : record
            case longint of
              0 : ( discrete : v4l2_fract );
              1 : ( stepwise : v4l2_frmival_stepwise );
            end;
        reserved : array[0..1] of __u32;
      end;

{$endif}
  {
   *	T I M E C O D E
    }

  type
    Pv4l2_timecode = ^v4l2_timecode;
    v4l2_timecode = record
        _type : __u32;
        flags : __u32;
        frames : __u8;
        seconds : __u8;
        minutes : __u8;
        hours : __u8;
        userbits : array[0..3] of __u8;
      end;

  {  Type   }

  const
    V4L2_TC_TYPE_24FPS = 1;    
    V4L2_TC_TYPE_25FPS = 2;    
    V4L2_TC_TYPE_30FPS = 3;    
    V4L2_TC_TYPE_50FPS = 4;    
    V4L2_TC_TYPE_60FPS = 5;    
  {  Flags   }
  { "drop-frame" mode  }
    V4L2_TC_FLAG_DROPFRAME = $0001;    
    V4L2_TC_FLAG_COLORFRAME = $0002;    
    V4L2_TC_USERBITS_field = $000C;    
    V4L2_TC_USERBITS_USERDEFINED = $0000;    
    V4L2_TC_USERBITS_8BITCHARS = $0008;    
  { The above is based on SMPTE timecodes  }
  { Number of APP segment to be written,
  				 * must be 0..15  }
  { Length of data in JPEG APPn segment  }
  { Data in the JPEG APPn segment.  }
  { Length of data in JPEG COM segment  }
  { Data in JPEG COM segment  }
  { Which markers should go into the JPEG
  				 * output. Unless you exactly know what
  				 * you do, leave them untouched.
  				 * Including less markers will make the
  				 * resulting code smaller, but there will
  				 * be fewer applications which can read it.
  				 * The presence of the APP and COM marker
  				 * is influenced by APP_len and COM_len
  				 * ONLY, not by this property!  }

  type
    Pv4l2_jpegcompression = ^v4l2_jpegcompression;
    v4l2_jpegcompression = record
        quality : longint;
        APPn : longint;
        APP_len : longint;
        APP_data : array[0..59] of char;
        COM_len : longint;
        COM_data : array[0..59] of char;
        jpeg_markers : __u32;
      end;

  { Define Huffman Tables  }

  const
    V4L2_JPEG_MARKER_DHT = 1 shl 3;    
  { Define Quantization Tables  }
    V4L2_JPEG_MARKER_DQT = 1 shl 4;    
  { Define Restart Interval  }
    V4L2_JPEG_MARKER_DRI = 1 shl 5;    
  { Comment segment  }
    V4L2_JPEG_MARKER_COM = 1 shl 6;    
  { App segment, driver will
  					* always use APP0  }
    V4L2_JPEG_MARKER_APP = 1 shl 7;    
  {
   *	M E M O R Y - M A P P I N G   B U F F E R S
    }
  { enum v4l2_buf_type  }
  { enum v4l2_memory  }

  type
    Pv4l2_requestbuffers = ^v4l2_requestbuffers;
    v4l2_requestbuffers = record
        count : __u32;
        _type : __u32;
        memory : __u32;
        reserved : array[0..1] of __u32;
      end;

  {*
   * struct v4l2_plane - plane info for multi-planar buffers
   * @bytesused:		number of bytes occupied by data in the plane (payload)
   * @length:		size of this plane (NOT the payload) in bytes
   * @mem_offset:		when memory in the associated struct v4l2_buffer is
   *			V4L2_MEMORY_MMAP, equals the offset from the start of
   *			the device memory for this plane (or is a "cookie" that
   *			should be passed to mmap() called on the video node)
   * @userptr:		when memory is V4L2_MEMORY_USERPTR, a userspace pointer
   *			pointing to this plane
   * @fd:			when memory is V4L2_MEMORY_DMABUF, a userspace file
   *			descriptor associated with this plane
   * @data_offset:	offset in the plane to the start of data; usually 0,
   *			unless there is a header in front of the data
   *
   * Multi-planar buffers consist of one or more planes, e.g. an YCbCr buffer
   * with two planes can have one plane for Y, and another for interleaved CbCr
   * components. Each plane can reside in a separate memory buffer, or even in
   * a completely separate memory node (e.g. in embedded devices).
    }
  {!!! unsigned long	userptr }
    Pv4l2_plane = ^v4l2_plane;
    v4l2_plane = record
        bytesused : __u32;
        length : __u32;
        m : record
            case longint of
              0 : ( mem_offset : __u32 );
              {$ifdef CPU32}
              1 : ( userptr : dword );
              {$ENDIF}
              {$ifdef CPU64}
              1 : ( userptr : __u64 );
              {$ENDIF}
              2 : ( fd : __s32 );
            end;
        data_offset : __u32;
        reserved : array[0..10] of __u32;
      end;

  {*
   * struct v4l2_buffer - video buffer info
   * @index:	id number of the buffer
   * @type:	enum v4l2_buf_type; buffer type (type == *_MPLANE for
   *		multiplanar buffers);
   * @bytesused:	number of bytes occupied by data in the buffer (payload);
   *		unused (set to 0) for multiplanar buffers
   * @flags:	buffer informational flags
   * @field:	enum v4l2_field; field order of the image in the buffer
   * @timestamp:	frame timestamp
   * @timecode:	frame timecode
   * @sequence:	sequence count of this frame
   * @memory:	enum v4l2_memory; the method, in which the actual video data is
   *		passed
   * @offset:	for non-multiplanar buffers with memory == V4L2_MEMORY_MMAP;
   *		offset from the start of the device memory for this plane,
   *		(or a "cookie" that should be passed to mmap() as offset)
   * @userptr:	for non-multiplanar buffers with memory == V4L2_MEMORY_USERPTR;
   *		a userspace pointer pointing to this buffer
   * @fd:		for non-multiplanar buffers with memory == V4L2_MEMORY_DMABUF;
   *		a userspace file descriptor associated with this buffer
   * @planes:	for multiplanar buffers; userspace pointer to the array of plane
   *		info structs for this buffer
   * @length:	size in bytes of the buffer (NOT its payload) for single-plane
   *		buffers (when type != *_MPLANE); number of elements in the
   *		planes array for multi-plane buffers
   * @input:	input number from which the video data has has been captured
   *
   * Contains data exchanged by application and driver using one of the Streaming
   * I/O methods.
    }
  { memory location  }
  {!!! unsigned long	userptr }
    Pv4l2_buffer = ^v4l2_buffer;
    v4l2_buffer = record
        index : __u32;
        _type : __u32;
        bytesused : __u32;
        flags : __u32;
        field : __u32;
        timestamp : timeval;
        timecode : v4l2_timecode;
        sequence : __u32;
        memory : __u32;
        m : record
            case longint of
              0 : ( offset : __u32 );
              {$ifdef CPU32}
              1 : ( userptr : dword );
              {$ENDIF}
              {$ifdef CPU64}
              1 : ( userptr : __u64 );
              {$ENDIF}
              2 : ( planes : Pv4l2_plane );
              3 : ( fd : __s32 );
            end;
        length : __u32;
        reserved2 : __u32;
        reserved : __u32;
      end;

  {  Flags for 'flags' field  }
  { Buffer is mapped (flag)  }

  const
    V4L2_BUF_FLAG_MAPPED = $0001;    
  { Buffer is queued for processing  }
    V4L2_BUF_FLAG_QUEUED = $0002;    
  { Buffer is ready  }
    V4L2_BUF_FLAG_DONE = $0004;    
  { Image is a keyframe (I-frame)  }
    V4L2_BUF_FLAG_KEYFRAME = $0008;    
  { Image is a P-frame  }
    V4L2_BUF_FLAG_PFRAME = $0010;    
  { Image is a B-frame  }
    V4L2_BUF_FLAG_BFRAME = $0020;    
  { Buffer is ready, but the data contained within is corrupted.  }
    V4L2_BUF_FLAG_ERROR = $0040;    
  { timecode field is valid  }
    V4L2_BUF_FLAG_TIMECODE = $0100;    
  { Buffer is prepared for queuing  }
    V4L2_BUF_FLAG_PREPARED = $0400;    
  { Cache handling flags  }
    V4L2_BUF_FLAG_NO_CACHE_INVALIDATE = $0800;    
    V4L2_BUF_FLAG_NO_CACHE_CLEAN = $1000;    
  { Timestamp type  }
    V4L2_BUF_FLAG_TIMESTAMP_MASK = $e000;    
    V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN = $0000;    
    V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC = $2000;    
    V4L2_BUF_FLAG_TIMESTAMP_COPY = $4000;    
  {*
   * struct v4l2_exportbuffer - export of video buffer as DMABUF file descriptor
   *
   * @index:	id number of the buffer
   * @type:	enum v4l2_buf_type; buffer type (type == *_MPLANE for
   *		multiplanar buffers);
   * @plane:	index of the plane to be exported, 0 for single plane queues
   * @flags:	flags for newly created file, currently only O_CLOEXEC is
   *		supported, refer to manual of open syscall for more details
   * @fd:		file descriptor associated with DMABUF (set by driver)
   *
   * Contains data used for exporting a video buffer as DMABUF file descriptor.
   * The buffer is identified by a 'cookie' returned by VIDIOC_QUERYBUF
   * (identical to the cookie used to mmap() the buffer to userspace). All
   * reserved fields must be set to zero. The field reserved0 is expected to
   * become a structure 'type' allowing an alternative layout of the structure
   * content. Therefore this field should not be used for any other extensions.
    }
  { enum v4l2_buf_type  }

  type
    Pv4l2_exportbuffer = ^v4l2_exportbuffer;
    v4l2_exportbuffer = record
        _type : __u32;
        index : __u32;
        plane : __u32;
        flags : __u32;
        fd : __s32;
        reserved : array[0..10] of __u32;
      end;

  {
   *	O V E R L A Y   P R E V I E W
    }
  { FIXME: in theory we should pass something like PCI device + memory
   * region + offset instead of some physical address  }
    Pv4l2_framebuffer = ^v4l2_framebuffer;
    v4l2_framebuffer = record
        capability : __u32;
        flags : __u32;
        base : pointer;
        fmt : v4l2_pix_format;
      end;

  {  Flags for the 'capability' field. Read only  }

  const
    V4L2_FBUF_CAP_EXTERNOVERLAY = $0001;    
    V4L2_FBUF_CAP_CHROMAKEY = $0002;    
    V4L2_FBUF_CAP_LIST_CLIPPING = $0004;    
    V4L2_FBUF_CAP_BITMAP_CLIPPING = $0008;    
    V4L2_FBUF_CAP_LOCAL_ALPHA = $0010;    
    V4L2_FBUF_CAP_GLOBAL_ALPHA = $0020;    
    V4L2_FBUF_CAP_LOCAL_INV_ALPHA = $0040;    
    V4L2_FBUF_CAP_SRC_CHROMAKEY = $0080;    
  {  Flags for the 'flags' field.  }
    V4L2_FBUF_FLAG_PRIMARY = $0001;    
    V4L2_FBUF_FLAG_OVERLAY = $0002;    
    V4L2_FBUF_FLAG_CHROMAKEY = $0004;    
    V4L2_FBUF_FLAG_LOCAL_ALPHA = $0008;    
    V4L2_FBUF_FLAG_GLOBAL_ALPHA = $0010;    
    V4L2_FBUF_FLAG_LOCAL_INV_ALPHA = $0020;    
    V4L2_FBUF_FLAG_SRC_CHROMAKEY = $0040;    
  {__user }
  type
    Pv4l2_clip = ^v4l2_clip;
    v4l2_clip = record
        c : v4l2_rect;
        next : Pv4l2_clip;
      end;

  { enum v4l2_field  }
  {__user }  {__user }    Pv4l2_window = ^v4l2_window;
    v4l2_window = record
        w : v4l2_rect;
        field : __u32;
        chromakey : __u32;
        clips : Pv4l2_clip;
        clipcount : __u32;
        bitmap : pointer;
        global_alpha : __u8;
      end;

  {
   *	C A P T U R E   P A R A M E T E R S
    }
  {  Supported modes  }
  {  Current mode  }
  {  Time per frame in seconds  }
  {  Driver-specific extensions  }
  {  # of buffers for read  }
    Pv4l2_captureparm = ^v4l2_captureparm;
    v4l2_captureparm = record
        capability : __u32;
        capturemode : __u32;
        timeperframe : v4l2_fract;
        extendedmode : __u32;
        readbuffers : __u32;
        reserved : array[0..3] of __u32;
      end;

  {  Flags for 'capability' and 'capturemode' fields  }
  {  High quality imaging mode  }

  const
    V4L2_MODE_HIGHQUALITY = $0001;    
  {  timeperframe field is supported  }
    V4L2_CAP_TIMEPERFRAME = $1000;    
  {  Supported modes  }
  {  Current mode  }
  {  Time per frame in seconds  }
  {  Driver-specific extensions  }
  {  # of buffers for write  }

  type
    Pv4l2_outputparm = ^v4l2_outputparm;
    v4l2_outputparm = record
        capability : __u32;
        outputmode : __u32;
        timeperframe : v4l2_fract;
        extendedmode : __u32;
        writebuffers : __u32;
        reserved : array[0..3] of __u32;
      end;

  {
   *	I N P U T   I M A G E   C R O P P I N G
    }
  { enum v4l2_buf_type  }
    Pv4l2_cropcap = ^v4l2_cropcap;
    v4l2_cropcap = record
        _type : __u32;
        bounds : v4l2_rect;
        defrect : v4l2_rect;
        pixelaspect : v4l2_fract;
      end;

  { enum v4l2_buf_type  }
    Pv4l2_crop = ^v4l2_crop;
    v4l2_crop = record
        _type : __u32;
        c : v4l2_rect;
      end;

  {*
   * struct v4l2_selection - selection info
   * @type:	buffer type (do not use *_MPLANE types)
   * @target:	Selection target, used to choose one of possible rectangles;
   *		defined in v4l2-common.h; V4L2_SEL_TGT_* .
   * @flags:	constraints flags, defined in v4l2-common.h; V4L2_SEL_FLAG_*.
   * @r:		coordinates of selection window
   * @reserved:	for future use, rounds structure size to 64 bytes, set to zero
   *
   * Hardware may use multiple helper windows to process a video stream.
   * The structure is used to exchange this selection areas between
   * an application and a driver.
    }
    Pv4l2_selection = ^v4l2_selection;
    v4l2_selection = record
        _type : __u32;
        target : __u32;
        flags : __u32;
        r : v4l2_rect;
        reserved : array[0..8] of __u32;
      end;

  {
   *      A N A L O G   V I D E O   S T A N D A R D
    }

    Pv4l2_std_id = ^v4l2_std_id;
    v4l2_std_id = __u64;
  { one bit for each  }
  {(v4l2_std_id) }
  const
    V4L2_STD_PAL_B = $00000001;    
  {(v4l2_std_id) }    V4L2_STD_PAL_B1 = $00000002;    
  {(v4l2_std_id) }    V4L2_STD_PAL_G = $00000004;    
  {(v4l2_std_id) }    V4L2_STD_PAL_H = $00000008;    
  {(v4l2_std_id) }    V4L2_STD_PAL_I = $00000010;    
  {(v4l2_std_id) }    V4L2_STD_PAL_D = $00000020;    
  {(v4l2_std_id) }    V4L2_STD_PAL_D1 = $00000040;    
  {(v4l2_std_id) }    V4L2_STD_PAL_K = $00000080;    
  {(v4l2_std_id) }    V4L2_STD_PAL_M = $00000100;    
  {(v4l2_std_id) }    V4L2_STD_PAL_N = $00000200;    
  {(v4l2_std_id) }    V4L2_STD_PAL_Nc = $00000400;    
  {(v4l2_std_id) }    V4L2_STD_PAL_60 = $00000800;    
  {(v4l2_std_id) }  { BTSC  }
    V4L2_STD_NTSC_M = $00001000;    
  {(v4l2_std_id) }  { EIA-J  }
    V4L2_STD_NTSC_M_JP = $00002000;    
  {(v4l2_std_id) }    V4L2_STD_NTSC_443 = $00004000;    
  {(v4l2_std_id) }  { FM A2  }
    V4L2_STD_NTSC_M_KR = $00008000;    
  {(v4l2_std_id) }    V4L2_STD_SECAM_B = $00010000;    
  {(v4l2_std_id) }    V4L2_STD_SECAM_D = $00020000;    
  {(v4l2_std_id) }    V4L2_STD_SECAM_G = $00040000;    
  {(v4l2_std_id) }    V4L2_STD_SECAM_H = $00080000;    
  {(v4l2_std_id) }    V4L2_STD_SECAM_K = $00100000;    
  {(v4l2_std_id) }    V4L2_STD_SECAM_K1 = $00200000;    
  {(v4l2_std_id) }    V4L2_STD_SECAM_L = $00400000;    
  {(v4l2_std_id) }    V4L2_STD_SECAM_LC = $00800000;    
  { ATSC/HDTV  }
  {(v4l2_std_id) }    V4L2_STD_ATSC_8_VSB = $01000000;    
  {(v4l2_std_id) }    V4L2_STD_ATSC_16_VSB = $02000000;    
  { FIXME:
     Although std_id is 64 bits, there is an issue on PPC32 architecture that
     makes switch(__u64) to break. So, there's a hack on v4l2-common.c rounding
     this value to 32 bits.
     As, currently, the max value is for V4L2_STD_ATSC_16_VSB (30 bits wide),
     it should work fine. However, if needed to add more than two standards,
     v4l2-common.c should be fixed.
    }
  {
   * Some macros to merge video standards in order to make live easier for the
   * drivers and V4L2 applications
    }
  {
   * "Common" NTSC/M - It should be noticed that V4L2_STD_NTSC_443 is
   * Missing here.
    }
    V4L2_STD_NTSC = (V4L2_STD_NTSC_M or V4L2_STD_NTSC_M_JP) or V4L2_STD_NTSC_M_KR;    
  { Secam macros  }
    V4L2_STD_SECAM_DK = (V4L2_STD_SECAM_D or V4L2_STD_SECAM_K) or V4L2_STD_SECAM_K1;    
  { All Secam Standards  }
    V4L2_STD_SECAM = ((((V4L2_STD_SECAM_B or V4L2_STD_SECAM_G) or V4L2_STD_SECAM_H) or V4L2_STD_SECAM_DK) or V4L2_STD_SECAM_L) or V4L2_STD_SECAM_LC;    
  { PAL macros  }
    V4L2_STD_PAL_BG = (V4L2_STD_PAL_B or V4L2_STD_PAL_B1) or V4L2_STD_PAL_G;    
    V4L2_STD_PAL_DK = (V4L2_STD_PAL_D or V4L2_STD_PAL_D1) or V4L2_STD_PAL_K;    
  {
   * "Common" PAL - This macro is there to be compatible with the old
   * V4L1 concept of "PAL": /BGDKHI.
   * Several PAL standards are missing here: /M, /N and /Nc
    }
    V4L2_STD_PAL = ((V4L2_STD_PAL_BG or V4L2_STD_PAL_DK) or V4L2_STD_PAL_H) or V4L2_STD_PAL_I;    
  { Chroma "agnostic" standards  }
    V4L2_STD_B = (V4L2_STD_PAL_B or V4L2_STD_PAL_B1) or V4L2_STD_SECAM_B;    
    V4L2_STD_G = V4L2_STD_PAL_G or V4L2_STD_SECAM_G;    
    V4L2_STD_H = V4L2_STD_PAL_H or V4L2_STD_SECAM_H;    
    V4L2_STD_L = V4L2_STD_SECAM_L or V4L2_STD_SECAM_LC;    
    V4L2_STD_GH = V4L2_STD_G or V4L2_STD_H;    
    V4L2_STD_DK = V4L2_STD_PAL_DK or V4L2_STD_SECAM_DK;    
    V4L2_STD_BG = V4L2_STD_B or V4L2_STD_G;    
    V4L2_STD_MN = ((V4L2_STD_PAL_M or V4L2_STD_PAL_N) or V4L2_STD_PAL_Nc) or V4L2_STD_NTSC;    
  { Standards where MTS/BTSC stereo could be found  }
    V4L2_STD_MTS = ((V4L2_STD_NTSC_M or V4L2_STD_PAL_M) or V4L2_STD_PAL_N) or V4L2_STD_PAL_Nc;    
  { Standards for Countries with 60Hz Line frequency  }
    V4L2_STD_525_60 = ((V4L2_STD_PAL_M or V4L2_STD_PAL_60) or V4L2_STD_NTSC) or V4L2_STD_NTSC_443;    
  { Standards for Countries with 50Hz Line frequency  }
    V4L2_STD_625_50 = ((V4L2_STD_PAL or V4L2_STD_PAL_N) or V4L2_STD_PAL_Nc) or V4L2_STD_SECAM;    
    V4L2_STD_ATSC = V4L2_STD_ATSC_8_VSB or V4L2_STD_ATSC_16_VSB;    
  { Macros with none and all analog standards  }
    V4L2_STD_UNKNOWN = 0;    
    V4L2_STD_ALL = V4L2_STD_525_60 or V4L2_STD_625_50;    
  { Frames, not fields  }

  type
    Pv4l2_standard = ^v4l2_standard;
    v4l2_standard = record
        index : __u32;
        id : v4l2_std_id;
        name : array[0..23] of __u8;
        frameperiod : v4l2_fract;
        framelines : __u32;
        reserved : array[0..3] of __u32;
      end;

  {
   *	D V 	B T	T I M I N G S
    }
  {* struct v4l2_bt_timings - BT.656/BT.1120 timing data
   * @width:	total width of the active video in pixels
   * @height:	total height of the active video in lines
   * @interlaced:	Interlaced or progressive
   * @polarities:	Positive or negative polarities
   * @pixelclock:	Pixel clock in HZ. Ex. 74.25MHz->74250000
   * @hfrontporch:Horizontal front porch in pixels
   * @hsync:	Horizontal Sync length in pixels
   * @hbackporch:	Horizontal back porch in pixels
   * @vfrontporch:Vertical front porch in lines
   * @vsync:	Vertical Sync length in lines
   * @vbackporch:	Vertical back porch in lines
   * @il_vfrontporch:Vertical front porch for the even field
   *		(aka field 2) of interlaced field formats
   * @il_vsync:	Vertical Sync length for the even field
   *		(aka field 2) of interlaced field formats
   * @il_vbackporch:Vertical back porch for the even field
   *		(aka field 2) of interlaced field formats
   * @standards:	Standards the timing belongs to
   * @flags:	Flags
   * @reserved:	Reserved fields, must be zeroed.
   *
   * A note regarding vertical interlaced timings: height refers to the total
   * height of the active video frame (= two fields). The blanking timings refer
   * to the blanking of each field. So the height of the total frame is
   * calculated as follows:
   *
   * tot_height = height + vfrontporch + vsync + vbackporch +
   *                       il_vfrontporch + il_vsync + il_vbackporch
   *
   * The active height of each field is height / 2.
    }
  {!!! __attribute__ ((packed)) }    Pv4l2_bt_timings = ^v4l2_bt_timings;
    v4l2_bt_timings = packed record
        width : __u32;
        height : __u32;
        interlaced : __u32;
        polarities : __u32;
        pixelclock : __u64;
        hfrontporch : __u32;
        hsync : __u32;
        hbackporch : __u32;
        vfrontporch : __u32;
        vsync : __u32;
        vbackporch : __u32;
        il_vfrontporch : __u32;
        il_vsync : __u32;
        il_vbackporch : __u32;
        standards : __u32;
        flags : __u32;
        reserved : array[0..13] of __u32;
      end;

  { Interlaced or progressive format  }

  const
    V4L2_DV_PROGRESSIVE = 0;    
    V4L2_DV_INTERLACED = 1;    
  { Polarities. If bit is not set, it is assumed to be negative polarity  }
    V4L2_DV_VSYNC_POS_POL = $00000001;    
    V4L2_DV_HSYNC_POS_POL = $00000002;    
  { Timings standards  }
  { CEA-861 Digital TV Profile  }
    V4L2_DV_BT_STD_CEA861 = 1 shl 0;    
  { VESA Discrete Monitor Timings  }
    V4L2_DV_BT_STD_DMT = 1 shl 1;    
  { VESA Coordinated Video Timings  }
    V4L2_DV_BT_STD_CVT = 1 shl 2;    
  { VESA Generalized Timings Formula  }
    V4L2_DV_BT_STD_GTF = 1 shl 3;    
  { Flags  }
  { CVT/GTF specific: timing uses reduced blanking (CVT) or the 'Secondary
     GTF' curve (GTF). In both cases the horizontal and/or vertical blanking
     intervals are reduced, allowing a higher resolution over the same
     bandwidth. This is a read-only flag.  }
    V4L2_DV_FL_REDUCED_BLANKING = 1 shl 0;    
  { CEA-861 specific: set for CEA-861 formats with a framerate of a multiple
     of six. These formats can be optionally played at 1 / 1.001 speed.
     This is a read-only flag.  }
    V4L2_DV_FL_CAN_REDUCE_FPS = 1 shl 1;    
  { CEA-861 specific: only valid for video transmitters, the flag is cleared
     by receivers.
     If the framerate of the format is a multiple of six, then the pixelclock
     used to set up the transmitter is divided by 1.001 to make it compatible
     with 60 Hz based standards such as NTSC and PAL-M that use a framerate of
     29.97 Hz. Otherwise this flag is cleared. If the transmitter can't generate
     such frequencies, then the flag will also be cleared.  }
    V4L2_DV_FL_REDUCED_FPS = 1 shl 2;    
  { Specific to interlaced formats: if set, then field 1 is really one half-line
     longer and field 2 is really one half-line shorter, so each field has
     exactly the same number of half-lines. Whether half-lines can be detected
     or used depends on the hardware.  }
    V4L2_DV_FL_HALF_LINE = 1 shl 3;    
  { A few useful defines to calculate the total blanking and frame sizes  }
  {
  #define V4L2_DV_BT_BLANKING_WIDTH(bt) \
  	(bt->hfrontporch + bt->hsync + bt->hbackporch)
  #define V4L2_DV_BT_FRAME_WIDTH(bt) \
  	(bt->width + V4L2_DV_BT_BLANKING_WIDTH(bt))
  #define V4L2_DV_BT_BLANKING_HEIGHT(bt) \
  	(bt->vfrontporch + bt->vsync + bt->vbackporch + \
  	 bt->il_vfrontporch + bt->il_vsync + bt->il_vbackporch)
  #define V4L2_DV_BT_FRAME_HEIGHT(bt) \
  	(bt->height + V4L2_DV_BT_BLANKING_HEIGHT(bt))
   }
  {* struct v4l2_dv_timings - DV timings
   * @type:	the type of the timings
   * @bt:	BT656/1120 timings
    }
  {!!! __attribute__ ((packed)) }
  type
    Pv4l2_dv_timings = ^v4l2_dv_timings;
    v4l2_dv_timings = packed record
        _type : __u32;
        u : record
            case longint of
              0 : ( bt : v4l2_bt_timings );
              1 : ( reserved : array[0..31] of __u32 );
            end;
      end;

  { Values for the type field  }
  { BT.656/1120 timing type  }

  const
    V4L2_DV_BT_656_1120 = 0;    
  {* struct v4l2_enum_dv_timings - DV timings enumeration
   * @index:	enumeration index
   * @reserved:	must be zeroed
   * @timings:	the timings for the given index
    }

  type
    Pv4l2_enum_dv_timings = ^v4l2_enum_dv_timings;
    v4l2_enum_dv_timings = record
        index : __u32;
        reserved : array[0..2] of __u32;
        timings : v4l2_dv_timings;
      end;

  {* struct v4l2_bt_timings_cap - BT.656/BT.1120 timing capabilities
   * @min_width:		width in pixels
   * @max_width:		width in pixels
   * @min_height:		height in lines
   * @max_height:		height in lines
   * @min_pixelclock:	Pixel clock in HZ. Ex. 74.25MHz->74250000
   * @max_pixelclock:	Pixel clock in HZ. Ex. 74.25MHz->74250000
   * @standards:		Supported standards
   * @capabilities:	Supported capabilities
   * @reserved:		Must be zeroed
    }
  {!!! __attribute__ ((packed)) }    Pv4l2_bt_timings_cap = ^v4l2_bt_timings_cap;
    v4l2_bt_timings_cap = packed record
        min_width : __u32;
        max_width : __u32;
        min_height : __u32;
        max_height : __u32;
        min_pixelclock : __u64;
        max_pixelclock : __u64;
        standards : __u32;
        capabilities : __u32;
        reserved : array[0..15] of __u32;
      end;

  { Supports interlaced formats  }

  const
    V4L2_DV_BT_CAP_INTERLACED = 1 shl 0;    
  { Supports progressive formats  }
    V4L2_DV_BT_CAP_PROGRESSIVE = 1 shl 1;    
  { Supports CVT/GTF reduced blanking  }
    V4L2_DV_BT_CAP_REDUCED_BLANKING = 1 shl 2;    
  { Supports custom formats  }
    V4L2_DV_BT_CAP_CUSTOM = 1 shl 3;    
  {* struct v4l2_dv_timings_cap - DV timings capabilities
   * @type:	the type of the timings (same as in struct v4l2_dv_timings)
   * @bt:		the BT656/1120 timings capabilities
    }

  type
    Pv4l2_dv_timings_cap = ^v4l2_dv_timings_cap;
    v4l2_dv_timings_cap = record
        _type : __u32;
        reserved : array[0..2] of __u32;
        u : record
            case longint of
              0 : ( bt : v4l2_bt_timings_cap );
              1 : ( raw_data : array[0..31] of __u32 );
            end;
      end;

  {
   *	V I D E O   I N P U T S
    }
  {  Which input  }
  {  Label  }
  {  Type of input  }
  {  Associated audios (bitfield)  }
  {  enum v4l2_tuner_type  }
    Pv4l2_input = ^v4l2_input;
    v4l2_input = record
        index : __u32;
        name : array[0..31] of __u8;
        _type : __u32;
        audioset : __u32;
        tuner : __u32;
        std : v4l2_std_id;
        status : __u32;
        capabilities : __u32;
        reserved : array[0..2] of __u32;
      end;

  {  Values for the 'type' field  }

  const
    V4L2_INPUT_TYPE_TUNER = 1;    
    V4L2_INPUT_TYPE_CAMERA = 2;    
  { field 'status' - general  }
  { Attached device is off  }
    V4L2_IN_ST_NO_POWER = $00000001;    
    V4L2_IN_ST_NO_SIGNAL = $00000002;    
    V4L2_IN_ST_NO_COLOR = $00000004;    
  { field 'status' - sensor orientation  }
  { If sensor is mounted upside down set both bits  }
  { Frames are flipped horizontally  }
    V4L2_IN_ST_HFLIP = $00000010;    
  { Frames are flipped vertically  }
    V4L2_IN_ST_VFLIP = $00000020;    
  { field 'status' - analog  }
  { No horizontal sync lock  }
    V4L2_IN_ST_NO_H_LOCK = $00000100;    
  { Color killer is active  }
    V4L2_IN_ST_COLOR_KILL = $00000200;    
  { field 'status' - digital  }
  { No synchronization lock  }
    V4L2_IN_ST_NO_SYNC = $00010000;    
  { No equalizer lock  }
    V4L2_IN_ST_NO_EQU = $00020000;    
  { Carrier recovery failed  }
    V4L2_IN_ST_NO_CARRIER = $00040000;    
  { field 'status' - VCR and set-top box  }
  { Macrovision detected  }
    V4L2_IN_ST_MACROVISION = $01000000;    
  { Conditional access denied  }
    V4L2_IN_ST_NO_ACCESS = $02000000;    
  { VTR time constant  }
    V4L2_IN_ST_VTR = $04000000;    
  { capabilities flags  }
  { Supports S_DV_TIMINGS  }
    V4L2_IN_CAP_DV_TIMINGS = $00000002;    
  { For compatibility  }
    V4L2_IN_CAP_CUSTOM_TIMINGS = V4L2_IN_CAP_DV_TIMINGS;    
  { Supports S_STD  }
    V4L2_IN_CAP_STD = $00000004;    
  {
   *	V I D E O   O U T P U T S
    }
  {  Which output  }
  {  Label  }
  {  Type of output  }
  {  Associated audios (bitfield)  }
  {  Associated modulator  }

  type
    Pv4l2_output = ^v4l2_output;
    v4l2_output = record
        index : __u32;
        name : array[0..31] of __u8;
        _type : __u32;
        audioset : __u32;
        modulator : __u32;
        std : v4l2_std_id;
        capabilities : __u32;
        reserved : array[0..2] of __u32;
      end;

  {  Values for the 'type' field  }

  const
    V4L2_OUTPUT_TYPE_MODULATOR = 1;    
    V4L2_OUTPUT_TYPE_ANALOG = 2;    
    V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY = 3;    
  { capabilities flags  }
  { Supports S_DV_TIMINGS  }
    V4L2_OUT_CAP_DV_TIMINGS = $00000002;    
  { For compatibility  }
    V4L2_OUT_CAP_CUSTOM_TIMINGS = V4L2_OUT_CAP_DV_TIMINGS;    
  { Supports S_STD  }
    V4L2_OUT_CAP_STD = $00000004;    
  {
   *	C O N T R O L S
    }

  type
    Pv4l2_control = ^v4l2_control;
    v4l2_control = record
        id : __u32;
        value : __s32;
      end;

  {!!! __attribute__ ((packed)) }    Pv4l2_ext_control = ^v4l2_ext_control;
    v4l2_ext_control = packed record
        id : __u32;
        size : __u32;
        reserved2 : array[0..0] of __u32;
        u : record
            case longint of
              0 : ( value : __s32 );
              1 : ( value64 : __s64 );
              2 : ( _string : Pchar );
            end;
      end;

    Pv4l2_ext_controls = ^v4l2_ext_controls;
    v4l2_ext_controls = record
        ctrl_class : __u32;
        count : __u32;
        error_idx : __u32;
        reserved : array[0..1] of __u32;
        controls : Pv4l2_ext_control;
      end;


  const
    V4L2_CTRL_ID_MASK = $0fffffff;    
  {
  #define V4L2_CTRL_ID2CLASS(id)    ((id) & 0x0fff0000UL)
  #define V4L2_CTRL_DRIVER_PRIV(id) (((id) & 0xffff) >= 0x1000)
   }

  type
    v4l2_ctrl_type =  Longint;
    Const
      V4L2_CTRL_TYPE_INTEGER = 1;
      V4L2_CTRL_TYPE_BOOLEAN = 2;
      V4L2_CTRL_TYPE_MENU = 3;
      V4L2_CTRL_TYPE_BUTTON = 4;
      V4L2_CTRL_TYPE_INTEGER64 = 5;
      V4L2_CTRL_TYPE_CTRL_CLASS = 6;
      V4L2_CTRL_TYPE_STRING = 7;
      V4L2_CTRL_TYPE_BITMASK = 8;
      V4L2_CTRL_TYPE_INTEGER_MENU = 9;

  {  Used in the VIDIOC_QUERYCTRL ioctl for querying controls  }
  { enum v4l2_ctrl_type  }
  { Whatever  }
  { Note signedness  }

  type
    Pv4l2_queryctrl = ^v4l2_queryctrl;
    v4l2_queryctrl = record
        id : __u32;
        _type : __u32;
        name : array[0..31] of char; // of __u8;
        minimum : __s32;
        maximum : __s32;
        step : __s32;
        default_value : __s32;
        flags : __u32;
        reserved : array[0..1] of __u32;
      end;

  {  Used in the VIDIOC_QUERYMENU ioctl for querying menu items  }
  { Whatever  }
  {!!! __attribute__ ((packed)) }    Pv4l2_querymenu = ^v4l2_querymenu;
    v4l2_querymenu = packed record
        id : __u32;
        index : __u32;
        u : record
            case longint of
              0 : ( name : array[0..31] of char ); // of __u8 );
              1 : ( value : __s64 );
            end;
        reserved : __u32;
      end;

  {  Control flags   }

  const
    V4L2_CTRL_FLAG_DISABLED = $0001;    
    V4L2_CTRL_FLAG_GRABBED = $0002;    
    V4L2_CTRL_FLAG_READ_ONLY = $0004;    
    V4L2_CTRL_FLAG_UPDATE = $0008;    
    V4L2_CTRL_FLAG_INACTIVE = $0010;    
    V4L2_CTRL_FLAG_SLIDER = $0020;    
    V4L2_CTRL_FLAG_WRITE_ONLY = $0040;    
    V4L2_CTRL_FLAG_VOLATILE = $0080;    
  {  Query flag, to be ORed with the control ID  }
    V4L2_CTRL_FLAG_NEXT_CTRL = $80000000;    
  {  User-class control IDs defined by V4L2  }
    V4L2_CID_MAX_CTRLS = 1024;    
  {  IDs reserved for driver specific controls  }
    V4L2_CID_PRIVATE_BASE = $08000000;    
  {
   *	T U N I N G
    }
  { enum v4l2_tuner_type  }

  type
    Pv4l2_tuner = ^v4l2_tuner;
    v4l2_tuner = record
        index : __u32;
        name : array[0..31] of __u8;
        _type : __u32;
        capability : __u32;
        rangelow : __u32;
        rangehigh : __u32;
        rxsubchans : __u32;
        audmode : __u32;
        signal : __s32;
        afc : __s32;
        reserved : array[0..3] of __u32;
      end;

    Pv4l2_modulator = ^v4l2_modulator;
    v4l2_modulator = record
        index : __u32;
        name : array[0..31] of __u8;
        capability : __u32;
        rangelow : __u32;
        rangehigh : __u32;
        txsubchans : __u32;
        reserved : array[0..3] of __u32;
      end;

  {  Flags for the 'capability' field  }

  const
    V4L2_TUNER_CAP_LOW = $0001;    
    V4L2_TUNER_CAP_NORM = $0002;    
    V4L2_TUNER_CAP_HWSEEK_BOUNDED = $0004;    
    V4L2_TUNER_CAP_HWSEEK_WRAP = $0008;    
    V4L2_TUNER_CAP_STEREO = $0010;    
    V4L2_TUNER_CAP_LANG2 = $0020;    
    V4L2_TUNER_CAP_SAP = $0020;    
    V4L2_TUNER_CAP_LANG1 = $0040;    
    V4L2_TUNER_CAP_RDS = $0080;    
    V4L2_TUNER_CAP_RDS_BLOCK_IO = $0100;    
    V4L2_TUNER_CAP_RDS_CONTROLS = $0200;    
    V4L2_TUNER_CAP_FREQ_BANDS = $0400;    
    V4L2_TUNER_CAP_HWSEEK_PROG_LIM = $0800;    
  {  Flags for the 'rxsubchans' field  }
    V4L2_TUNER_SUB_MONO = $0001;    
    V4L2_TUNER_SUB_STEREO = $0002;    
    V4L2_TUNER_SUB_LANG2 = $0004;    
    V4L2_TUNER_SUB_SAP = $0004;    
    V4L2_TUNER_SUB_LANG1 = $0008;    
    V4L2_TUNER_SUB_RDS = $0010;    
  {  Values for the 'audmode' field  }
    V4L2_TUNER_MODE_MONO = $0000;    
    V4L2_TUNER_MODE_STEREO = $0001;    
    V4L2_TUNER_MODE_LANG2 = $0002;    
    V4L2_TUNER_MODE_SAP = $0002;    
    V4L2_TUNER_MODE_LANG1 = $0003;    
    V4L2_TUNER_MODE_LANG1_LANG2 = $0004;    
  { enum v4l2_tuner_type  }

  type
    Pv4l2_frequency = ^v4l2_frequency;
    v4l2_frequency = record
        tuner : __u32;
        _type : __u32;
        frequency : __u32;
        reserved : array[0..7] of __u32;
      end;


  const
    V4L2_BAND_MODULATION_VSB = 1 shl 1;    
    V4L2_BAND_MODULATION_FM = 1 shl 2;    
    V4L2_BAND_MODULATION_AM = 1 shl 3;    
  { enum v4l2_tuner_type  }

  type
    Pv4l2_frequency_band = ^v4l2_frequency_band;
    v4l2_frequency_band = record
        tuner : __u32;
        _type : __u32;
        index : __u32;
        capability : __u32;
        rangelow : __u32;
        rangehigh : __u32;
        modulation : __u32;
        reserved : array[0..8] of __u32;
      end;

  { enum v4l2_tuner_type  }
    Pv4l2_hw_freq_seek = ^v4l2_hw_freq_seek;
    v4l2_hw_freq_seek = record
        tuner : __u32;
        _type : __u32;
        seek_upward : __u32;
        wrap_around : __u32;
        spacing : __u32;
        rangelow : __u32;
        rangehigh : __u32;
        reserved : array[0..4] of __u32;
      end;

  {
   *	R D S
    }
  {!!! __attribute__ ((packed)) }    Pv4l2_rds_data = ^v4l2_rds_data;
    v4l2_rds_data = packed record
        lsb : __u8;
        msb : __u8;
        block : __u8;
      end;


  const
    V4L2_RDS_BLOCK_MSK = $7;    
    V4L2_RDS_BLOCK_A = 0;    
    V4L2_RDS_BLOCK_B = 1;    
    V4L2_RDS_BLOCK_C = 2;    
    V4L2_RDS_BLOCK_D = 3;    
    V4L2_RDS_BLOCK_C_ALT = 4;    
    V4L2_RDS_BLOCK_INVALID = 7;    
    V4L2_RDS_BLOCK_CORRECTED = $40;    
    V4L2_RDS_BLOCK_ERROR = $80;    
  {
   *	A U D I O
    }

  type
    Pv4l2_audio = ^v4l2_audio;
    v4l2_audio = record
        index : __u32;
        name : array[0..31] of __u8;
        capability : __u32;
        mode : __u32;
        reserved : array[0..1] of __u32;
      end;

  {  Flags for the 'capability' field  }

  const
    V4L2_AUDCAP_STEREO = $00001;    
    V4L2_AUDCAP_AVL = $00002;    
  {  Flags for the 'mode' field  }
    V4L2_AUDMODE_AVL = $00001;    

  type
    Pv4l2_audioout = ^v4l2_audioout;
    v4l2_audioout = record
        index : __u32;
        name : array[0..31] of __u8;
        capability : __u32;
        mode : __u32;
        reserved : array[0..1] of __u32;
      end;

  {
   *	M P E G   S E R V I C E S
   *
   *	NOTE: EXPERIMENTAL API
    }
{$if 1}

  const
    V4L2_ENC_IDX_FRAME_I = 0;    
    V4L2_ENC_IDX_FRAME_P = 1;    
    V4L2_ENC_IDX_FRAME_B = 2;    
    V4L2_ENC_IDX_FRAME_MASK = $f;    

  type
    Pv4l2_enc_idx_entry = ^v4l2_enc_idx_entry;
    v4l2_enc_idx_entry = record
        offset : __u64;
        pts : __u64;
        length : __u32;
        flags : __u32;
        reserved : array[0..1] of __u32;
      end;


  const
    V4L2_ENC_IDX_ENTRIES = 64;    

  type
    Pv4l2_enc_idx = ^v4l2_enc_idx;
    v4l2_enc_idx = record
        entries : __u32;
        entries_cap : __u32;
        reserved : array[0..3] of __u32;
        entry : array[0..(V4L2_ENC_IDX_ENTRIES)-1] of v4l2_enc_idx_entry;
      end;


  const
    V4L2_ENC_CMD_START = 0;    
    V4L2_ENC_CMD_STOP = 1;    
    V4L2_ENC_CMD_PAUSE = 2;    
    V4L2_ENC_CMD_RESUME = 3;    
  { Flags for V4L2_ENC_CMD_STOP  }
    V4L2_ENC_CMD_STOP_AT_GOP_END = 1 shl 0;    

  type
    Pv4l2_encoder_cmd = ^v4l2_encoder_cmd;
    v4l2_encoder_cmd = record
        cmd : __u32;
        flags : __u32;
        u : record
            case longint of
              0 : ( raw : record
                  data : array[0..7] of __u32;
                end );
            end;
      end;

  { Decoder commands  }

  const
    V4L2_DEC_CMD_START = 0;    
    V4L2_DEC_CMD_STOP = 1;    
    V4L2_DEC_CMD_PAUSE = 2;    
    V4L2_DEC_CMD_RESUME = 3;    
  { Flags for V4L2_DEC_CMD_START  }
    V4L2_DEC_CMD_START_MUTE_AUDIO = 1 shl 0;    
  { Flags for V4L2_DEC_CMD_PAUSE  }
    V4L2_DEC_CMD_PAUSE_TO_BLACK = 1 shl 0;    
  { Flags for V4L2_DEC_CMD_STOP  }
    V4L2_DEC_CMD_STOP_TO_BLACK = 1 shl 0;    
    V4L2_DEC_CMD_STOP_IMMEDIATELY = 1 shl 1;    
  { Play format requirements (returned by the driver):  }
  { The decoder has no special format requirements  }
    V4L2_DEC_START_FMT_NONE = 0;    
  { The decoder requires full GOPs  }
    V4L2_DEC_START_FMT_GOP = 1;    
  { The structure must be zeroed before use by the application
     This ensures it can be extended safely in the future.  }
  { 0 or 1000 specifies normal speed,
  			   1 specifies forward single stepping,
  			   -1 specifies backward single stepping,
  			   >1: playback at speed/1000 of the normal speed,
  			   <-1: reverse playback at (-speed/1000) of the normal speed.  }

  type
    Pv4l2_decoder_cmd = ^v4l2_decoder_cmd;
    v4l2_decoder_cmd = record
        cmd : __u32;
        flags : __u32;
        u : record
            case longint of
              0 : ( stop : record
                  pts : __u64;
                end );
              1 : ( start : record
                  speed : __s32;
                  format : __u32;
                end );
              2 : ( raw : record
                  data : array[0..15] of __u32;
                end );
            end;
      end;

{$endif}
  {
   *	D A T A   S E R V I C E S   ( V B I )
   *
   *	Data services API by Michael Schimek
    }
  { Raw VBI  }
  { in 1 Hz  }
  { V4L2_PIX_FMT_*  }
  { V4L2_VBI_*  }
  { must be zero  }

  type
    Pv4l2_vbi_format = ^v4l2_vbi_format;
    v4l2_vbi_format = record
        sampling_rate : __u32;
        offset : __u32;
        samples_per_line : __u32;
        sample_format : __u32;
        start : array[0..1] of __s32;
        count : array[0..1] of __u32;
        flags : __u32;
        reserved : array[0..1] of __u32;
      end;

  {  VBI flags   }

  const
    V4L2_VBI_UNSYNC = 1 shl 0;    
    V4L2_VBI_INTERLACED = 1 shl 1;    
  { Sliced VBI
   *
   *    This implements is a proposal V4L2 API to allow SLICED VBI
   * required for some hardware encoders. It should change without
   * notice in the definitive implementation.
    }
  { service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
  	   service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
  				 (equals frame lines 313-336 for 625 line video
  				  standards, 263-286 for 525 line standards)  }
  { must be zero  }

  type
    Pv4l2_sliced_vbi_format = ^v4l2_sliced_vbi_format;
    v4l2_sliced_vbi_format = record
        service_set : __u16;
        service_lines : array[0..1] of array[0..23] of __u16;
        io_size : __u32;
        reserved : array[0..1] of __u32;
      end;

  { Teletext World System Teletext
     (WST), defined on ITU-R BT.653-2  }

  const
    V4L2_SLICED_TELETEXT_B = $0001;    
  { Video Program System, defined on ETS 300 231 }
    V4L2_SLICED_VPS = $0400;    
  { Closed Caption, defined on EIA-608  }
    V4L2_SLICED_CAPTION_525 = $1000;    
  { Wide Screen System, defined on ITU-R BT1119.1  }
    V4L2_SLICED_WSS_625 = $4000;    
    V4L2_SLICED_VBI_525 = V4L2_SLICED_CAPTION_525;    
    V4L2_SLICED_VBI_625 = (V4L2_SLICED_TELETEXT_B or V4L2_SLICED_VPS) or V4L2_SLICED_WSS_625;    
  { service_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
  	   service_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
  				 (equals frame lines 313-336 for 625 line video
  				  standards, 263-286 for 525 line standards)  }
  { enum v4l2_buf_type  }
  { must be 0  }

  type
    Pv4l2_sliced_vbi_cap = ^v4l2_sliced_vbi_cap;
    v4l2_sliced_vbi_cap = record
        service_set : __u16;
        service_lines : array[0..1] of array[0..23] of __u16;
        _type : __u32;
        reserved : array[0..2] of __u32;
      end;

  { 0: first field, 1: second field  }
  { 1-23  }
  { must be 0  }
    Pv4l2_sliced_vbi_data = ^v4l2_sliced_vbi_data;
    v4l2_sliced_vbi_data = record
        id : __u32;
        field : __u32;
        line : __u32;
        reserved : __u32;
        data : array[0..47] of __u8;
      end;

  {
   * Sliced VBI data inserted into MPEG Streams
    }
  {
   * V4L2_MPEG_STREAM_VBI_FMT_IVTV:
   *
   * Structure of payload contained in an MPEG 2 Private Stream 1 PES Packet in an
   * MPEG-2 Program Pack that contains V4L2_MPEG_STREAM_VBI_FMT_IVTV Sliced VBI
   * data
   *
   * Note, the MPEG-2 Program Pack and Private Stream 1 PES packet header
   * definitions are not included here.  See the MPEG-2 specifications for details
   * on these headers.
    }
  { Line type IDs  }

  const
    V4L2_MPEG_VBI_IVTV_TELETEXT_B = 1;    
    V4L2_MPEG_VBI_IVTV_CAPTION_525 = 4;    
    V4L2_MPEG_VBI_IVTV_WSS_625 = 5;    
    V4L2_MPEG_VBI_IVTV_VPS = 7;    
  { One of V4L2_MPEG_VBI_IVTV_* above  }
  { Sliced VBI data for the line  }
  {!!! __attribute__ ((packed)) }
  type
    Pv4l2_mpeg_vbi_itv0_line = ^v4l2_mpeg_vbi_itv0_line;
    v4l2_mpeg_vbi_itv0_line = packed record
        id : __u8;
        data : array[0..41] of __u8;
      end;

  { Bitmasks of VBI service lines present  }
  {!!! __attribute__ ((packed)) }    Pv4l2_mpeg_vbi_itv0 = ^v4l2_mpeg_vbi_itv0;
    v4l2_mpeg_vbi_itv0 = packed record
        linemask : array[0..1] of __le32;
        line : array[0..34] of v4l2_mpeg_vbi_itv0_line;
      end;

  {!!! __attribute__ ((packed)) }    Pv4l2_mpeg_vbi_ITV1 = ^v4l2_mpeg_vbi_ITV1;
    v4l2_mpeg_vbi_ITV1 = packed record
        line : array[0..35] of v4l2_mpeg_vbi_itv0_line;
      end;


  const
    V4L2_MPEG_VBI_IVTV_MAGIC0 = 'itv0';    
    V4L2_MPEG_VBI_IVTV_MAGIC1 = 'ITV0';    
  {!!! __attribute__ ((packed)) }
  type
    Pv4l2_mpeg_vbi_fmt_ivtv = ^v4l2_mpeg_vbi_fmt_ivtv;
    v4l2_mpeg_vbi_fmt_ivtv = packed record
        magic : array[0..3] of __u8;
        u : record
            case longint of
              0 : ( itv0 : v4l2_mpeg_vbi_itv0 );
              1 : ( ITV1 : v4l2_mpeg_vbi_ITV1 );
            end;
      end;

  {
   *	A G G R E G A T E   S T R U C T U R E S
    }
  {*
   * struct v4l2_plane_pix_format - additional, per-plane format definition
   * @sizeimage:		maximum size in bytes required for data, for which
   *			this plane will be used
   * @bytesperline:	distance in bytes between the leftmost pixels in two
   *			adjacent lines
    }
  {!!! __attribute__ ((packed)) }    Pv4l2_plane_pix_format = ^v4l2_plane_pix_format;
    v4l2_plane_pix_format = packed record
        sizeimage : __u32;
        bytesperline : __u16;
        reserved : array[0..6] of __u16;
      end;

  {*
   * struct v4l2_pix_format_mplane - multiplanar format definition
   * @width:		image width in pixels
   * @height:		image height in pixels
   * @pixelformat:	little endian four character code (fourcc)
   * @field:		enum v4l2_field; field order (for interlaced video)
   * @colorspace:		enum v4l2_colorspace; supplemental to pixelformat
   * @plane_fmt:		per-plane information
   * @num_planes:		number of planes for this format
    }
  {!!! __attribute__ ((packed)) }    Pv4l2_pix_format_mplane = ^v4l2_pix_format_mplane;
    v4l2_pix_format_mplane = packed record
        width : __u32;
        height : __u32;
        pixelformat : __u32;
        field : __u32;
        colorspace : __u32;
        plane_fmt : array[0..(VIDEO_MAX_PLANES)-1] of v4l2_plane_pix_format;
        num_planes : __u8;
        reserved : array[0..10] of __u8;
      end;

  {*
   * struct v4l2_format - stream data format
   * @type:	enum v4l2_buf_type; type of the data stream
   * @pix:	definition of an image format
   * @pix_mp:	definition of a multiplanar image format
   * @win:	definition of an overlaid image
   * @vbi:	raw VBI capture or output parameters
   * @sliced:	sliced VBI capture or output parameters
   * @raw_data:	placeholder for future extensions and custom formats
    }
  { V4L2_BUF_TYPE_VIDEO_CAPTURE  }
  { V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE  }
  { V4L2_BUF_TYPE_VIDEO_OVERLAY  }
  { V4L2_BUF_TYPE_VBI_CAPTURE  }
  { V4L2_BUF_TYPE_SLICED_VBI_CAPTURE  }
  { user-defined  }
    Pv4l2_format = ^v4l2_format;
    v4l2_format = record
        _type : __u32;
        fmt : record
            case longint of
              0 : ( pix : v4l2_pix_format );
              1 : ( pix_mp : v4l2_pix_format_mplane );
              2 : ( win : v4l2_window );
              3 : ( vbi : v4l2_vbi_format );
              4 : ( sliced : v4l2_sliced_vbi_format );
              5 : ( raw_data : array[0..199] of __u8 );
            end;
      end;

  {	Stream type-dependent parameters
    }
  { enum v4l2_buf_type  }
  { user-defined  }
    Pv4l2_streamparm = ^v4l2_streamparm;
    v4l2_streamparm = record
        _type : __u32;
        parm : record
            case longint of
              0 : ( capture : v4l2_captureparm );
              1 : ( output : v4l2_outputparm );
              2 : ( raw_data : array[0..199] of __u8 );
            end;
      end;

  {
   *	E V E N T S
    }

  const
    V4L2_EVENT_ALL = 0;    
    V4L2_EVENT_VSYNC = 1;    
    V4L2_EVENT_EOS = 2;    
    V4L2_EVENT_CTRL = 3;    
    V4L2_EVENT_FRAME_SYNC = 4;    
    V4L2_EVENT_PRIVATE_START = $08000000;    
  { Payload for V4L2_EVENT_VSYNC  }
  { Can be V4L2_FIELD_ANY, _NONE, _TOP or _BOTTOM  }
  {!!! __attribute__ ((packed)) }
  type
    Pv4l2_event_vsync = ^Tv4l2_event_vsync;
    Tv4l2_event_vsync = packed record
        field : __u8;
      end;

  { Payload for V4L2_EVENT_CTRL  }

  const
    V4L2_EVENT_CTRL_CH_VALUE = 1 shl 0;    
    V4L2_EVENT_CTRL_CH_FLAGS = 1 shl 1;    
    V4L2_EVENT_CTRL_CH_RANGE = 1 shl 2;    

  type
    Pv4l2_event_ctrl = ^Tv4l2_event_ctrl;
    Tv4l2_event_ctrl = record
        changes : __u32;
        _type : __u32;
        u : record
            case longint of
              0 : ( value : __s32 );
              1 : ( value64 : __s64 );
            end;
        flags : __u32;
        minimum : __s32;
        maximum : __s32;
        step : __s32;
        default_value : __s32;
      end;

    Pv4l2_event_frame_sync = ^Tv4l2_event_frame_sync;
    Tv4l2_event_frame_sync = record
        frame_sequence : __u32;
      end;

    Pv4l2_event = ^v4l2_event;
    v4l2_event = record
        _type : __u32;
        u : record
            case longint of
              0 : ( vsync : Tv4l2_event_vsync );
              1 : ( ctrl : Tv4l2_event_ctrl );
              2 : ( frame_sync : Tv4l2_event_frame_sync );
              3 : ( data : array[0..63] of __u8 );
            end;
        pending : __u32;
        sequence : __u32;
        timestamp : timespec;
        id : __u32;
        reserved : array[0..7] of __u32;
      end;


  const
    V4L2_EVENT_SUB_FL_SEND_INITIAL = 1 shl 0;    
    V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK = 1 shl 1;    

  type
    Pv4l2_event_subscription = ^v4l2_event_subscription;
    v4l2_event_subscription = record
        _type : __u32;
        id : __u32;
        flags : __u32;
        reserved : array[0..4] of __u32;
      end;

  {
   *	A D V A N C E D   D E B U G G I N G
   *
   *	NOTE: EXPERIMENTAL API, NEVER RELY ON THIS IN APPLICATIONS!
   *	FOR DEBUGGING, TESTING AND INTERNAL USE ONLY!
    }
  { VIDIOC_DBG_G_REGISTER and VIDIOC_DBG_S_REGISTER  }
  { Match against chip ID on the bridge (0 for the bridge)  }

  const
    V4L2_CHIP_MATCH_BRIDGE = 0;    
  { Match against subdev index  }
    V4L2_CHIP_MATCH_SUBDEV = 4;    
  { The following four defines are no longer in use  }
    V4L2_CHIP_MATCH_HOST = V4L2_CHIP_MATCH_BRIDGE;    
  { Match against I2C driver name  }
    V4L2_CHIP_MATCH_I2C_DRIVER = 1;    
  { Match against I2C 7-bit address  }
    V4L2_CHIP_MATCH_I2C_ADDR = 2;    
  { Match against ancillary AC97 chip  }
    V4L2_CHIP_MATCH_AC97 = 3;    
  { Match type  }
  { Match this chip, meaning determined by type  }
  {!!! __attribute__ ((packed)) }
  type
    Pv4l2_dbg_match = ^v4l2_dbg_match;
    v4l2_dbg_match = packed record
        _type : __u32;
        u : record
            case longint of
              0 : ( addr : __u32 );
              1 : ( name : array[0..31] of char );
            end;
      end;

  { register size in bytes  }
  {!!! __attribute__ ((packed)) }    Pv4l2_dbg_register = ^v4l2_dbg_register;
    v4l2_dbg_register = packed record
        match : v4l2_dbg_match;
        size : __u32;
        reg : __u64;
        val : __u64;
      end;


  const
    V4L2_CHIP_FL_READABLE = 1 shl 0;    
    V4L2_CHIP_FL_WRITABLE = 1 shl 1;    
  { VIDIOC_DBG_G_CHIP_INFO  }
  {!!! __attribute__ ((packed)) }
  type
    Pv4l2_dbg_chip_info = ^v4l2_dbg_chip_info;
    v4l2_dbg_chip_info = packed record
        match : v4l2_dbg_match;
        name : array[0..31] of char;
        flags : __u32;
        reserved : array[0..31] of __u32;
      end;

  {*
   * struct v4l2_create_buffers - VIDIOC_CREATE_BUFS argument
   * @index:	on return, index of the first created buffer
   * @count:	entry: number of requested buffers,
   *		return: number of created buffers
   * @memory:	enum v4l2_memory; buffer memory type
   * @format:	frame format, for which buffers are requested
   * @reserved:	future extensions
    }
    Pv4l2_create_buffers = ^v4l2_create_buffers;
    v4l2_create_buffers = record
        index : __u32;
        count : __u32;
        memory : __u32;
        format : v4l2_format;
        reserved : array[0..7] of __u32;
      end;

{
 *      I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
 *
 }
const    
  VIDIOC_QUERYCAP          = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (0 shl _IOC_NRSHIFT) or (SizeOf(v4l2_capability) shl _IOC_SIZESHIFT));
  VIDIOC_RESERVED           = LongInt((_IOC_NONE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (1 shl _IOC_NRSHIFT) or (0 shl _IOC_SIZESHIFT));
  VIDIOC_ENUM_FMT         = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (2 shl _IOC_NRSHIFT) or (SizeOf(v4l2_fmtdesc) shl _IOC_SIZESHIFT));
  VIDIOC_G_FMT            = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (4 shl _IOC_NRSHIFT) or (SizeOf(v4l2_format) shl _IOC_SIZESHIFT));
  VIDIOC_S_FMT            = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (5 shl _IOC_NRSHIFT) or (SizeOf(v4l2_format) shl _IOC_SIZESHIFT));
  VIDIOC_REQBUFS          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (8 shl _IOC_NRSHIFT) or (SizeOf(v4l2_requestbuffers) shl _IOC_SIZESHIFT));
  VIDIOC_QUERYBUF         = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (9 shl _IOC_NRSHIFT) or (SizeOf(v4l2_buffer) shl _IOC_SIZESHIFT));
  VIDIOC_G_FBUF            = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (10 shl _IOC_NRSHIFT) or (SizeOf(v4l2_framebuffer) shl _IOC_SIZESHIFT));
  VIDIOC_S_FBUF            = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (11 shl _IOC_NRSHIFT) or (SizeOf(v4l2_framebuffer) shl _IOC_SIZESHIFT));
  VIDIOC_OVERLAY           = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (14 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_QBUF             = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (15 shl _IOC_NRSHIFT) or (SizeOf(v4l2_buffer) shl _IOC_SIZESHIFT));
  VIDIOC_EXPBUF           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (16 shl _IOC_NRSHIFT) or (SizeOf(v4l2_exportbuffer) shl _IOC_SIZESHIFT));
  VIDIOC_DQBUF            = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (17 shl _IOC_NRSHIFT) or (SizeOf(v4l2_buffer) shl _IOC_SIZESHIFT));
  VIDIOC_STREAMON          = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (18 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_STREAMOFF         = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (19 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_G_PARM           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (21 shl _IOC_NRSHIFT) or (SizeOf(v4l2_streamparm) shl _IOC_SIZESHIFT));
  VIDIOC_S_PARM           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (22 shl _IOC_NRSHIFT) or (SizeOf(v4l2_streamparm) shl _IOC_SIZESHIFT));
  VIDIOC_G_STD             = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (23 shl _IOC_NRSHIFT) or (SizeOf(v4l2_std_id) shl _IOC_SIZESHIFT));
  VIDIOC_S_STD             = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (24 shl _IOC_NRSHIFT) or (SizeOf(v4l2_std_id) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMSTD          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (25 shl _IOC_NRSHIFT) or (SizeOf(v4l2_standard) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMINPUT        = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (26 shl _IOC_NRSHIFT) or (SizeOf(v4l2_input) shl _IOC_SIZESHIFT));
  VIDIOC_G_CTRL           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (27 shl _IOC_NRSHIFT) or (SizeOf(v4l2_control) shl _IOC_SIZESHIFT));
  VIDIOC_S_CTRL           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (28 shl _IOC_NRSHIFT) or (SizeOf(v4l2_control) shl _IOC_SIZESHIFT));
  VIDIOC_G_TUNER          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (29 shl _IOC_NRSHIFT) or (SizeOf(v4l2_tuner) shl _IOC_SIZESHIFT));
  VIDIOC_S_TUNER           = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (30 shl _IOC_NRSHIFT) or (SizeOf(v4l2_tuner) shl _IOC_SIZESHIFT));
  VIDIOC_G_AUDIO           = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (33 shl _IOC_NRSHIFT) or (SizeOf(v4l2_audio) shl _IOC_SIZESHIFT));
  VIDIOC_S_AUDIO           = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (34 shl _IOC_NRSHIFT) or (SizeOf(v4l2_audio) shl _IOC_SIZESHIFT));
  VIDIOC_QUERYCTRL        = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (36 shl _IOC_NRSHIFT) or (SizeOf(v4l2_queryctrl) shl _IOC_SIZESHIFT));
  VIDIOC_QUERYMENU        = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (37 shl _IOC_NRSHIFT) or (SizeOf(v4l2_querymenu) shl _IOC_SIZESHIFT));
  VIDIOC_G_INPUT           = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (38 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_S_INPUT          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (39 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_G_OUTPUT          = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (46 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_S_OUTPUT         = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (47 shl _IOC_NRSHIFT) or (SizeOf(LongInt) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMOUTPUT       = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (48 shl _IOC_NRSHIFT) or (SizeOf(v4l2_output) shl _IOC_SIZESHIFT));
  VIDIOC_G_AUDOUT          = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (49 shl _IOC_NRSHIFT) or (SizeOf(v4l2_audioout) shl _IOC_SIZESHIFT));
  VIDIOC_S_AUDOUT          = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (50 shl _IOC_NRSHIFT) or (SizeOf(v4l2_audioout) shl _IOC_SIZESHIFT));
  VIDIOC_G_MODULATOR      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (54 shl _IOC_NRSHIFT) or (SizeOf(v4l2_modulator) shl _IOC_SIZESHIFT));
  VIDIOC_S_MODULATOR       = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (55 shl _IOC_NRSHIFT) or (SizeOf(v4l2_modulator) shl _IOC_SIZESHIFT));
  VIDIOC_G_FREQUENCY      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (56 shl _IOC_NRSHIFT) or (SizeOf(v4l2_frequency) shl _IOC_SIZESHIFT));
  VIDIOC_S_FREQUENCY       = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (57 shl _IOC_NRSHIFT) or (SizeOf(v4l2_frequency) shl _IOC_SIZESHIFT));
  VIDIOC_CROPCAP          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (58 shl _IOC_NRSHIFT) or (SizeOf(v4l2_cropcap) shl _IOC_SIZESHIFT));
  VIDIOC_G_CROP           = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (59 shl _IOC_NRSHIFT) or (SizeOf(v4l2_crop) shl _IOC_SIZESHIFT));
  VIDIOC_S_CROP            = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (60 shl _IOC_NRSHIFT) or (SizeOf(v4l2_crop) shl _IOC_SIZESHIFT));
  VIDIOC_G_JPEGCOMP        = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (61 shl _IOC_NRSHIFT) or (SizeOf(v4l2_jpegcompression) shl _IOC_SIZESHIFT));
  VIDIOC_S_JPEGCOMP        = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (62 shl _IOC_NRSHIFT) or (SizeOf(v4l2_jpegcompression) shl _IOC_SIZESHIFT));
  VIDIOC_QUERYSTD          = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (63 shl _IOC_NRSHIFT) or (SizeOf(v4l2_std_id) shl _IOC_SIZESHIFT));
  VIDIOC_TRY_FMT          = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (64 shl _IOC_NRSHIFT) or (SizeOf(v4l2_format) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMAUDIO        = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (65 shl _IOC_NRSHIFT) or (SizeOf(v4l2_audio) shl _IOC_SIZESHIFT));
  VIDIOC_ENUMAUDOUT       = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (66 shl _IOC_NRSHIFT) or (SizeOf(v4l2_audioout) shl _IOC_SIZESHIFT));
  VIDIOC_G_PRIORITY        = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (67 shl _IOC_NRSHIFT) or (SizeOf(__u32) shl _IOC_SIZESHIFT)); { enum v4l2_priority *}
  VIDIOC_S_PRIORITY        = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (68 shl _IOC_NRSHIFT) or (SizeOf(__u32) shl _IOC_SIZESHIFT)); { enum v4l2_priority *}
  VIDIOC_G_SLICED_VBI_CAP = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (69 shl _IOC_NRSHIFT) or (SizeOf(v4l2_sliced_vbi_cap) shl _IOC_SIZESHIFT));
  VIDIOC_LOG_STATUS         = LongInt((_IOC_NONE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (70 shl _IOC_NRSHIFT) or (0 shl _IOC_SIZESHIFT));
  VIDIOC_G_EXT_CTRLS      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (71 shl _IOC_NRSHIFT) or (SizeOf(v4l2_ext_controls) shl _IOC_SIZESHIFT));
  VIDIOC_S_EXT_CTRLS      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (72 shl _IOC_NRSHIFT) or (SizeOf(v4l2_ext_controls) shl _IOC_SIZESHIFT));
  VIDIOC_TRY_EXT_CTRLS    = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (73 shl _IOC_NRSHIFT) or (SizeOf(v4l2_ext_controls) shl _IOC_SIZESHIFT));
  VIDIOC_ENUM_FRAMESIZES  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (74 shl _IOC_NRSHIFT) or (SizeOf(v4l2_frmsizeenum) shl _IOC_SIZESHIFT));
  VIDIOC_ENUM_FRAMEINTERVALS = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (75 shl _IOC_NRSHIFT) or (SizeOf(v4l2_frmivalenum) shl _IOC_SIZESHIFT));
  VIDIOC_G_ENC_INDEX       = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (76 shl _IOC_NRSHIFT) or (SizeOf(v4l2_enc_idx) shl _IOC_SIZESHIFT));
  VIDIOC_ENCODER_CMD      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (77 shl _IOC_NRSHIFT) or (SizeOf(v4l2_encoder_cmd) shl _IOC_SIZESHIFT));
  VIDIOC_TRY_ENCODER_CMD  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (78 shl _IOC_NRSHIFT) or (SizeOf(v4l2_encoder_cmd) shl _IOC_SIZESHIFT));

{ Experimental, meant for debugging, testing and internal use.
   Only implemented if CONFIG_VIDEO_ADV_DEBUG is defined.
   You must be root to use these ioctls. Never use these in applications! }
  VIDIOC_DBG_S_REGISTER    = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (79 shl _IOC_NRSHIFT) or (SizeOf(v4l2_dbg_register) shl _IOC_SIZESHIFT));
  VIDIOC_DBG_G_REGISTER   = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (80 shl _IOC_NRSHIFT) or (SizeOf(v4l2_dbg_register) shl _IOC_SIZESHIFT));

  VIDIOC_S_HW_FREQ_SEEK    = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (82 shl _IOC_NRSHIFT) or (SizeOf(v4l2_hw_freq_seek) shl _IOC_SIZESHIFT));

  VIDIOC_S_DV_TIMINGS     = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (87 shl _IOC_NRSHIFT) or (SizeOf(v4l2_dv_timings) shl _IOC_SIZESHIFT));
  VIDIOC_G_DV_TIMINGS     = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (88 shl _IOC_NRSHIFT) or (SizeOf(v4l2_dv_timings) shl _IOC_SIZESHIFT));
  VIDIOC_DQEVENT           = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (89 shl _IOC_NRSHIFT) or (SizeOf(v4l2_event) shl _IOC_SIZESHIFT));
  VIDIOC_SUBSCRIBE_EVENT   = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (90 shl _IOC_NRSHIFT) or (SizeOf(v4l2_event_subscription) shl _IOC_SIZESHIFT));
  VIDIOC_UNSUBSCRIBE_EVENT = LongInt((_IOC_WRITE shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (91 shl _IOC_NRSHIFT) or (SizeOf(v4l2_event_subscription) shl _IOC_SIZESHIFT));

{ Experimental, the below two ioctls may change over the next couple of kernel
   versions }
  VIDIOC_CREATE_BUFS      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (92 shl _IOC_NRSHIFT) or (SizeOf(v4l2_create_buffers) shl _IOC_SIZESHIFT));
  VIDIOC_PREPARE_BUF      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (93 shl _IOC_NRSHIFT) or (SizeOf(v4l2_buffer) shl _IOC_SIZESHIFT));

{ Experimental selection API }
  VIDIOC_G_SELECTION      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (94 shl _IOC_NRSHIFT) or (SizeOf(v4l2_selection) shl _IOC_SIZESHIFT));
  VIDIOC_S_SELECTION      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (95 shl _IOC_NRSHIFT) or (SizeOf(v4l2_selection) shl _IOC_SIZESHIFT));

{ Experimental, these two ioctls may change over the next couple of kernel
   versions. }
  VIDIOC_DECODER_CMD      = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (96 shl _IOC_NRSHIFT) or (SizeOf(v4l2_decoder_cmd) shl _IOC_SIZESHIFT));
  VIDIOC_TRY_DECODER_CMD  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (97 shl _IOC_NRSHIFT) or (SizeOf(v4l2_decoder_cmd) shl _IOC_SIZESHIFT));

{ Experimental, these three ioctls may change over the next couple of kernel
   versions. }
  VIDIOC_ENUM_DV_TIMINGS  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (98 shl _IOC_NRSHIFT) or (SizeOf(v4l2_enum_dv_timings) shl _IOC_SIZESHIFT));
  VIDIOC_QUERY_DV_TIMINGS  = LongInt((_IOC_READ shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (99 shl _IOC_NRSHIFT) or (SizeOf(v4l2_dv_timings) shl _IOC_SIZESHIFT));
  VIDIOC_DV_TIMINGS_CAP   = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (100 shl _IOC_NRSHIFT) or (SizeOf(v4l2_dv_timings_cap) shl _IOC_SIZESHIFT));

{ Experimental, this ioctl may change over the next couple of kernel
   versions. }
  VIDIOC_ENUM_FREQ_BANDS  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (101 shl _IOC_NRSHIFT) or (SizeOf(v4l2_frequency_band) shl _IOC_SIZESHIFT));

{ Experimental, meant for debugging, testing and internal use.
   Never use these in applications! }
  VIDIOC_DBG_G_CHIP_INFO  = LongInt(((_IOC_READ or _IOC_WRITE) shl _IOC_DIRSHIFT) or (Ord('V') shl _IOC_TYPESHIFT) or (102 shl _IOC_NRSHIFT) or (SizeOf(v4l2_dbg_chip_info) shl _IOC_SIZESHIFT));

{ Reminder: when adding new ioctls please add support for them to
   drivers/media/video/v4l2-compat-ioctl32.c as well! }

{$endif}
   { _UAPI__LINUX_VIDEODEV2_H  }

implementation

end.
