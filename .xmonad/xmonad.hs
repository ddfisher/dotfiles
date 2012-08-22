import XMonad
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

import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS


myWorkspaces :: [String]
myWorkspaces = map show [1..4 :: Int]

myLayoutHook = desktopLayoutModifiers $ mkToggle (FULL ?? EOT) $ boringWindows $ minimize (spiral (6/7) ||| Tall 1 (3/100) (1/2))

main = xmonad $ kde4Config
          { modMask = mod4Mask
          , startupHook = spawn "xcompmgr"  >> spawn "killall krunner" >> spawn "krunner" -- start xcompmgr for opacity; restart krunner to fix strange problem
          , manageHook = ((className =? "krunner") >>= return . not --> manageHook kde4Config)
                          <+> (kdeOverride --> doFloat) 
                          <+> myManageHook
          , workspaces = myWorkspaces
          , layoutHook = myLayoutHook
          , logHook = fadeInactiveLogHook 0.85 <+> logHook kde4Config -- set unfocused windows to 85% opacity (good with dark backgrounds)

          , terminal = "konsole"
          , borderWidth = 0
          }
          `additionalKeys`
          [ ((mod4Mask, xK_grave), kill) -- Meta-` closes focused window
          , ((mod4Mask, xK_g), goToSelected defaultGSConfig) -- GridSelect

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
          ]

myManageHook = composeAll . concat $
  [ [ className =? c --> doFloat | c <- ["MPlayer", "Gimp", "Klipper"] ] ]

-- magic from the internet: may or may not be useful
kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (elem $ fromIntegral override) wt
