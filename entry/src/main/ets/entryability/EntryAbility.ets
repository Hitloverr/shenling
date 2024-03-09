import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import { UserSettingClass } from '../utils/setting';
import { Advert } from '../models/advert';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    const userSetting = new UserSettingClass(this.context);

    // 尝试去读一下运营的配置，模拟一下
    const result = await new Promise<Advert>((resolve,reject)=>{
      setTimeout(()=>{
        resolve({
          showAd: true,
          adTime: 10,
          adImage: $r('app.media.start')
        } as Advert)
      },500)
    })

    await userSetting.setUserAd(result)
    const adSetting = await userSetting.getUserAd();
    if (adSetting.showAd) {
      windowStage.loadContent('pages/start/Start');
    } else {
      const token = userSetting.getUserToken();
      if (token) {
        windowStage.loadContent('pages/Index')
      } else {
        windowStage.loadContent('pages/Login/Login')
      }
    }
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
