import preferences from '@ohos.data.preferences';
import { USER_SETTING, USER_SETTING_AD } from '../constants/setting_key';
import { TOKEN_KEY } from '../constants/token_key';
import { Advert } from '../models/advert';

const defaultAd: Advert = {
  showAd: true,
  adTime: 5,
  adImage: $r('app.media.start')
}

export class UserSettingClass {
  context: Context;

  constructor(context: Context) {
    this.context = context;
  }

  // 获取存储用户信息的首选项仓库
  getStore() {
    return preferences.getPreferences(this.context, USER_SETTING); // 用getContext还不太对。
  }

  async setUserAd(ad: Advert) {
    const adStore = await this.getStore();
    await adStore.put(USER_SETTING_AD, JSON.stringify(ad));
    await adStore.flush();
  }

  async getUserAd() {
    const adStore = await this.getStore();
    return JSON.parse(await adStore.get(USER_SETTING_AD, JSON.stringify(defaultAd)) as string) as Advert
  }

  async setUserToken(token: string) {
    const store = await this.getStore();
    await store.put(TOKEN_KEY, token);
    await store.flush();
  }

  async getUserToken() {
    const store = await this.getStore();
    return await store.get(TOKEN_KEY, "") as string;
  }
}