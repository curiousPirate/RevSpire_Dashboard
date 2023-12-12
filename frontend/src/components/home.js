import React, { useContext } from "react";
import "./home.css";
import { globalContext } from "../App";

const formatDate = (dateString) => {
  const options = { day: "numeric", month: "numeric", year: "numeric" };
  return new Date(dateString).toLocaleDateString(undefined, options);
};

export function Home() {
  const { responseData } = useContext(globalContext);

  return (
    <div className="home">
      {responseData !== null ? (
        <table>
          <thead>
            <tr>
              <td>
                <div className="circle circleTH"></div>
              </td>
              <th>Name</th>
              <th>ID</th>
              <th>Source</th>
              <th>Created By</th>
              <th>Created Date</th>
              <th>Modified By</th>
              <th>Modified Date</th>
            </tr>
          </thead>
          <tbody>
            {responseData.map((data, index) => (
              <tr key={index}>
                <td>
                  <div className="circle"></div>
                </td>
                <td>{data.name}</td>
                <td>{data.id}</td>
                <td>{data.source}</td>
                <td>{data.created_by}</td>
                <td>{formatDate(data.created_at)}</td>
                <td>{data.updated_by}</td>
                <td>{formatDate(data.updated_at)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>No data available</p>
      )}
    </div>
  );
}
