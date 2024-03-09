import { TOKEN_KEY } from '../../constants/token_key'
import { UserSettingClass } from '../../utils/setting';

PersistentStorage.PersistProp(TOKEN_KEY,"");
@Entry
@Component
struct Login {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Button('登录')
          .onClick(()=>{
            AppStorage.Set(TOKEN_KEY,'1234565');
            new UserSettingClass(getContext(this)).setUserToken('1234565');
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}