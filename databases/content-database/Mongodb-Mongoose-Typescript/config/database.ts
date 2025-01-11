import process from 'node:process';
import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

const DEFAULT_CONNECTION_STRING = 'mongodb://localhost:27017/content'

export const connectMongoDB = async (): Promise<void> => {
  try {
    await mongoose.connect(process.env.MONGODB_URI || DEFAULT_CONNECTION_STRING);
    console.log('MongoDB connected successfully');
  } catch (error) {
    console.error('MongoDB connection error:', error);
    process.exit(1);
  }
};

export const disconnectMongoDB = async (): Promise<void> => {
  await mongoose.disconnect();
  console.log('MongoDB disconnected');
};