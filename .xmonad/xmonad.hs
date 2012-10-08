import XMonad
import qualified XMonad.StackSet as W
import XMonad.Config.Kde
import XMonad.Config.Desktop

import XMonad.Layout.Spiral
import XMonad.Layout.Minimize
import XMonad.Layout.BoringWindows
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

import XMonad.Util.EZConfig
import XMonad.Util.WindowProperties (getProp32s)

import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops

import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdateFocus

import XMonad.Hooks.SetWMName


myWorkspaces :: [String]
myWorkspaces = map show [1..4 :: Int]

myLayoutHook = desktopLayoutModifiers $ mkToggle (FULL ?? EOT) $ boringWindows $ minimize (spiral (6/7) ||| Tall 1 (3/100) (1/2))

main = xmonad $ kde4Config
          { modMask = mod4Mask
          , startupHook = spawn "xcompmgr" -- start xcompmgr for opacity
          , manageHook = ((className =? "krunner") >>= return . not --> manageHook kde4Config)
                          -- <+> (kdeOverride --> doFloat) 
                          <+> myManageHook
          , handleEventHook = handleEventHook kde4Config <+> fullscreenEventHook
          , workspaces = myWorkspaces
          , layoutHook = myLayoutHook
          , logHook = fadeInactiveLogHook 0.85 <+> logHook kde4Config -- set unfocused windows to 85% opacity (good with dark backgrounds)

          , terminal = "konsole"
          , borderWidth = 0
          }
          `additionalKeys`
          [ ((mod4Mask, xK_grave), kill) -- closes focused window
          , ((mod4Mask, xK_Escape), spawn "~/scripts/silent_lock.bash") -- turn off screen and lock
          , ((mod4Mask, xK_g), goToSelected defaultGSConfig) -- GridSelect
          , ((mod4Mask, xK_c), spawn "google-chrome") -- Open Chrome

          , ((mod4Mask, xK_k), focusUp) -- using BoringWindows to skip focusing minimized windows
          , ((mod4Mask, xK_j), focusDown)


          , ((mod4Mask, xK_m), withFocused minimizeWindow) -- minimize focused window
          , ((mod4Mask .|. shiftMask, xK_m), sendMessage RestoreNextMinimizedWin) -- unminimize a window

          , ((mod4Mask, xK_f), sendMessage (Toggle FULL) >> sendMessage ToggleStruts) -- toggle fullscreen

          , ((mod4Mask, xK_z), toggleWS) -- go to most recently viewed workspace
          , ((mod4Mask, xK_Right), nextWS) -- go one workspace right
          , ((mod4Mask, xK_Left), prevWS) -- go one workspace left
          , ((mod4Mask .|. shiftMask, xK_Right), shiftToNext >> nextWS) -- move window one workspace right and follow it
          , ((mod4Mask .|. shiftMask, xK_Left), shiftToPrev >> prevWS) -- move window one workspace left and follow it

          -- volume adjustment
          , ((mod4Mask, xK_bracketleft), spawn "amixer -- set Master playback 5%-")
          , ((mod4Mask, xK_bracketright), spawn "amixer -- set Master playback 5%+")
          ]

myManageHook = composeAll . concat $
  [ [ className =? c --> doFloat | c <- ["MPlayer", "Gimp", "Klipper", "Plasma-desktop"] ]
  , [isFullscreen --> doFullFloat]
  ]

-- magic from the internet: may or may not be useful
kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (elem $ fromIntegral override) wt
