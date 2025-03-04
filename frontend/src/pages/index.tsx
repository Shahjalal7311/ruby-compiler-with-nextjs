import { useState } from 'react';
import axios from 'axios';
import Card from '@/components/ui/card';
import CardContent from "@/components/ui/cardContent";
import Button from '@/components/ui/button';

export default function Compiler() {
  const [code, setCode] = useState('');
  const [language, setLanguage] = useState('');
  const [output, setOutput] = useState('');
  const [status, setStatus] = useState('');
  const [executionTime, setExecutionTime] = useState(null);
  const [shareLink, setShareLink] = useState('');

  const handleCompile = async () => {
    const formData = new FormData();
    formData.append('compilation[language]', language);
    formData.append('compilation[code]', code);
    try {
      const response = await axios.post('http://localhost:3003/api/v1/compilations', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      const { id, output, status, execution_time } = response.data;
      setOutput(output);
      setStatus(status);
      setExecutionTime(execution_time);
      setShareLink(`${window.location.origin}/compilation/${id}`);
    } catch (error) {
      setOutput('Compilation failed.');
      setStatus('error');
    }
  };

  const handleShare = () => {
    if (shareLink) {
      navigator.clipboard.writeText(shareLink);
      alert('Link copied to clipboard!');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-r from-blue-50 to-purple-50 p-6">
      <div className="max-w-full mx-auto flex gap-8">
        {/* Left Side: Input Section */}
        <div className="flex-1 bg-white rounded-lg shadow-lg p-8">
          <h1 className="text-3xl font-bold text-gray-800 mb-8">Multi-language Code Compiler</h1>

          {/* Language Selection */}
          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-2">Select Language:</label>
            <select
              value={language}
              onChange={(e) => setLanguage(e.target.value)}
              className="w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="">Select One</option>
              <option value="ruby">Ruby</option>
              <option value="php">PHP</option>
              <option value="javascript">JavaScript</option>
							<option value="python">Python</option>
            </select>
          </div>

          {/* Code Input */}
          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-2">Enter Your Code:</label>
            <textarea
              value={code}
              onChange={(e) => setCode(e.target.value)}
              rows={15}
              className="w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="Enter your code here..."
            />
          </div>

          {/* Buttons */}
          <div className="flex gap-4 mb-6">
            <Button
              onClick={handleCompile}
              className="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-6 rounded-lg shadow-md transition duration-300"
            >
              Run Code
            </Button>
            {shareLink && (
              <Button
                onClick={handleShare}
                className="bg-purple-600 hover:bg-purple-700 text-white font-semibold py-2 px-6 rounded-lg shadow-md transition duration-300"
              >
                Share Result
              </Button>
            )}
          </div>
        </div>

        {/* Right Side: Output Section */}
        <div className="flex-1 bg-white rounded-lg shadow-lg p-8">
          <h2 className="text-xl font-semibold text-gray-800 mb-4">Compilation Output</h2>
          <div className="space-y-4">
            <p className="text-sm text-gray-700">
              <span className="font-medium">Status:</span> {status}
            </p>
            <p className="text-sm text-gray-700">
              <span className="font-medium">Execution Time:</span> {executionTime ? `${executionTime}s` : 'N/A'}
            </p>
            <pre className="h-[455px] bg-gray-50 p-4 rounded-lg border border-gray-200 text-sm text-gray-800 whitespace-pre-wrap">
              {output}
            </pre>
          </div>
        </div>
      </div>
    </div>
  );
}