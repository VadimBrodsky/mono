---
title: "Simple State Machine with useReducer"
tags: ["react", "xstate"]
created: "20220601204720881"
modified: "20220602154242093"
---

Inspired by XState, we can use `useReducer`

```javascript
export const timerMachineConfig = {
  initial: 'idle',
  states: {
    idle: {
      on: {
        TOGGLE: 'running',
      },
    },
    running: {
      on: {
        TOGGLE: 'paused',
      },
    },
    paused: {
      on: {
        TOGGLE: 'running',
        RESET: 'idle',
      },
    },
  },
};

export const timerMachine = (state, event) => {
  return timerMachineConfig.states[state].on[event.type] || state;

  /*
  if (event.type === 'TOGGLE' && state === 'idle') {
    return 'running';
  }

  if (event.type === 'TOGGLE' && state === 'running') {
    return 'paused';
  }

  if (event.type === 'TOGGLE' && state === 'paused') {
    return 'running';
  }

  if (event.type === 'RESET' && state === 'paused') {
    return 'idle';
  }
  */

  return state;
};
```

Use it in a component:

```javascript
import { timerMachine, timerMachineConfig } from './timerMachine';

export const Timer = () => {
  const [state, dispatch] = useReducer(timerMachine, timerMachineConfig.initial);

  const { duration, elapsed, interval } = {
    duration: 60,
    elapsed: 0,
    interval: 0.1,
  };

  return (
    <div className="timer">
      <ProgressCircle />
      <div className="display">
        <div className="label">{state}</div>
        <div
          className="elapsed"
          onClick={() => {
            dispatch({ type: 'TOGGLE' });
          }}
        >
          {Math.ceil(duration - elapsed)}
        </div>
        <div className="controls">
          <button
            onClick={() => {
              dispatch({ type: 'RESET' });
            }}
          >
            Reset
          </button>
        </div>
      </div>
      <div className="actions">
        {state === 'running' && (
          <button
            onClick={() => {
              dispatch({ type: 'TOGGLE' });
            }}
            title="Pause timer"
          >
            <FontAwesomeIcon icon={faPause} />
          </button>
        )}

        {(state === 'paused' || state === 'idle') && (
          <button
            onClick={() => {
              dispatch({ type: 'TOGGLE' });
            }}
            title="Start timer"
          >
            <FontAwesomeIcon icon={faPlay} />
          </button>
        )}
      </div>
    </div>
  );
};
```
