export enum LogLevel {
  INFO, WARN, ERROR,
}

// assuming the log entries are from database
export type Log = {
  id: string; message: string; level: LogLevel; timestamp: number
}


