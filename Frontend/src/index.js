import './index.css';
import React from 'react';
import ReactDOM from 'react-dom/client';
import {createBrowserRouter, RouterProvider} from "react-router-dom";

import App from './routes/App';
import Start from './routes/Start'
import Levels from './routes/Levels'

export const backenduri = 'http://localhost:8080'

const router = createBrowserRouter([
  {
    path: "/",
    element: <Start />,
  },
  {
    path: "levels/",
    element: <Levels />
  },
  {
    path: "levels/:level1",
    element: <App />,
  },
]);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);