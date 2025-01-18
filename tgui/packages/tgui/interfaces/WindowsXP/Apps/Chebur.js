import { useLocalState } from '../../../backend';
import chebur from '../../../assets/WindowsXP/chebur.png';
import { Button, TextArea} from '../../../components';

export const Cheburnet = (props, context) => {
  const { app, act } = props;
  const [poiski, setMessage] = useLocalState(context, 'cheburnet_poiski', '');
  return (
    <div className="news__screen">
      <img width="200px" src={chebur} />
      <div className="news__text">{app.shrek}</div>
      {app.can_sond === 1 && (
        <div className="news__actions">
          <TextArea
            placeholder={'Введите запрос'}
            onChange={(e, value) => {
              setMessage(value);
            }}
            className="chat-input"
          />
          <Button
            icon="paper-plane"
            onClick={() => {
              act('poiskovik', { poiski: poiski });
              setMessage('');
            }}
          />
        </div>
      )}
    </div>
  );
};
