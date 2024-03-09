import { Advert } from '../../models'
import { UserSettingClass } from '../../utils'
import router from '@ohos.router'
import { TOKEN_KEY } from '../../constants/token_key'

PersistentStorage.PersistProp(TOKEN_KEY,"");

@Entry
@Component
struct Start {
  userSetting: UserSettingClass = new UserSettingClass(getContext(this))
  @State
  adObj: Advert  = {
    showAd: false,
    adTime: 0,
    adImage: ''
  }
  timer: number = -1
  async aboutToAppear() {
    this.adObj = await this.userSetting.getUserAd()
    this.timer = setInterval(() => {
      if(this.adObj.adTime === 0) {
        clearInterval(this.timer)
        this.toNext();
        return
      }
      this.adObj.adTime--
    }, 1000)
  }
  aboutToDisappear() {
    clearInterval(this.timer)
  }

  private toNext() {
    const token = this.userSetting.getUserToken();
    if (token) {
      router.replaceUrl({
        url: 'pages/Index'
      })
    } else {
      router.replaceUrl({
        url: 'pages/Login/Login'
      })
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image(this.adObj.adImage).objectFit(ImageFit.Cover)
      Text(`${this.adObj.adTime}秒后跳过`)
        .padding({ left: 10, right: 10 })
        .margin({ right: 20, top: 20 })
        .height(30)
        .fontSize(14)
        .borderRadius(15)
        .backgroundColor($r('app.color.background_page'))
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.toNext();
        })

    }.height('100%').width('100%')
  }
}
