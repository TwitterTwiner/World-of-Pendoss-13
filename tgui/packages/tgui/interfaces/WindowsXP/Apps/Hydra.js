import { useLocalState } from '../../../backend';
import { TextArea, Input } from '../../../components';
import chebur from '../../../assets/WindowsXP/chebur.png';

export const Hydra = (props, context) => {
  const { app, act } = props;
  const [username, setUsername] = useLocalState(context, 'hydra_username', '');
  return app.username === '' ? (
    <div className="visitor">
      <div>
        <img width="120px" src={chebur} />
        <div className="visitor-text">Enter username:</div>
        <Input
          className="user-input"
          onChange={(e, value) => setUsername(value)}
        />
        <button
          type="button"
          onClick={() => {
            act('hydra_login_user', { username: username, ref: app.reference });
            setUsername('');
          }}
          className="login-button">
          <div className="visitor-text">Login</div>
        </button>
      </div>
    </div>
  ) : (
    <div className="chebur">
      <div className="chat-header">
        <img src={chebur} className="picture" />
        <div className="user-info">
          <div className="header-container">
            <div className="username">{app.username}</div>
            <div>{'Version 1.0 (Beta)'}</div>
          </div>
          <TextArea
            value={message}
            placeholder={'Enter some text...'}
            className="userinfo"
          />
        </div>
      </div>
      <div className="chat">
        <div className="chat-footer">
          <div class="messages">
            {app.messages.map(message => {
              return (
                <>
                  <b>{message.author}</b>
                  <div>{message.message}</div>
                </>
              );
            })}
          </div>
          <TextArea
            placeholder={'Enter message...'}
            onChange={(e, value) => {
              setMessage(value);
            }}
            className="chat-input"
          />
          <div
            onClick={() => {
              act('send_message', { ref: app.reference, message: message });
              setMessage('');
            }}
            className="send-button">
            <b style={{ color: 'black' }}>Send</b>
          </div>
        </div>
      </div>
    </div>
  );
};
