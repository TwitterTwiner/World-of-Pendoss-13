import icqIcon from '../../assets/WindowsXP/icq.png';
import notepadIcon from '../../assets/WindowsXP/327(32x32).png';
import errorIcon from '../../assets/WindowsXP/897(32x32).png';
import gmailicon from '../../assets/WindowsXP/gmail_icon.png';
import newsIcon from '../../assets/WindowsXP/news.png';
import cheburIcon from '../../assets/WindowsXP/chebur.png';
import hydraIcon from '../../assets/WindowsXP/sosal.png'

import { Notepad } from './Apps/Notepad';
import { ICQ as Icq } from './Apps/ICQ';
import { Error } from './Apps/Error';
import { Gmail } from './Apps/Gmail';
import { News } from './Apps/News';
import { Cheburnet } from './Apps/Chebur';
import { Hydra } from './Apps/Hydra';


export const GetIconByName = name => {
  switch (name) {
    case "icq":
      return icqIcon;
    case "notepad":
      return notepadIcon;
    case "error":
      return errorIcon;
    case "gmail":
      return gmailicon;
    case "news":
      return newsIcon;
    case "cheburnet":
      return cheburIcon;
    case "hydra":
      return hydraIcon;
    default:
      return null;
  }
};

export const GetAppByName = (app, act) => {
  switch (app.type) {
    case "icq":
      return <Icq app={app} act={act} />;
    case "notepad":
      return <Notepad app={app} act={act} />;
    case "error":
      return <Error app={app} act={act} />;
    case "gmail":
      return <Gmail app={app} act={act} />;
    case "news":
      return <News app={app} act={act} />;
    case "hydra":
      return <Hydra app={app} act={act} />;
    case "cheburnet":
      return <Cheburnet app={app} act={act} />;
    default:
      return null;
  }
};
