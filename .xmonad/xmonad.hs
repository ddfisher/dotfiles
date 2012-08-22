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

import XMonad.Actions.GridSelect


myWorkspaces :: [String]
myWorkspaces = map show [1..4 :: Int]

myLayoutHook = desktopLayoutModifiers $ mkToggle (FULL ?? EOT) $ boringWindows $ minimize (spiral (6/7) ||| Tall 1 (3/100) (1/2))

main = xmonad $ kde4Config
          { modMask = mod4Mask
          , startupHook = spawn "xcompmgr"  >> spawn "killall krunner" >> spawn "krunner"
          , manageHook = ((className =? "krunner") >>= return . not --> manageHook kde4Config)
                          <+> (kdeOverride --> doFloat) 
                          <+> myManageHook
          , workspaces = myWorkspaces
          , layoutHook = myLayoutHook
          , logHook = fadeInactiveLogHook 0.85 <+> logHook kde4Config

          , terminal = "konsole"
          , borderWidth = 0
          }
          `additionalKeys`
          [ ((mod4Mask, xK_grave), kill)
          , ((mod4Mask, xK_g), goToSelected defaultGSConfig)

          , ((mod4Mask, xK_k), focusUp) -- for BoringWindows
          , ((mod4Mask, xK_j), focusDown)


          , ((mod4Mask, xK_m), withFocused minimizeWindow)
          , ((mod4Mask .|. shiftMask, xK_m), sendMessage RestoreNextMinimizedWin)

          , ((mod4Mask, xK_f), sendMessage $ Toggle FULL)
          ]

myManageHook = composeAll . concat $
  [ [ className =? c --> doFloat | c <- ["MPlayer", "Gimp", "Klipper"] ] ]

kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
    override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
    return $ maybe False (elem $ fromIntegral override) wt
