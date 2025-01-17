import { useLocalState } from '../../../backend';
import chebur from '../../../assets/WindowsXP/chebur.png';
import { Button, Input } from '../../../components';

export const Cheburnet = (props, context) => {
  const { app, act } = props;
  const [poiski, setMessage] = useLocalState(context, 'news_message', '');
  return (
    <div className="chebu__screen">
      <img width="180px" src={chebur} />
      <div className="news__text">{app.shrek}</div>
      {app.can_send === 1 && (
        <div className="news__actions">
          <Input
            value={poiski}
            onChange={(e, value) => setMessage(value)}
            placeholder="Введите запрос..."
          />
          <Button
            icon="paper-plane"
            onClick={() => {
              act('news_send_message', { poiski: message });
              setMessage('');
            }}
          />
        </div>
      )}
    </div>
  );
};
