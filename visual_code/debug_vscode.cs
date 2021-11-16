while (!System.Diagnostics.Debugger.IsAttached)
{
  System.Console.WriteLine($"waiting to debug on {Environment.ProcessId}...");
  System.Threading.Thread.Sleep(1000);
}
