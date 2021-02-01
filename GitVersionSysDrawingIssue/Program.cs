using System;
using System.Reflection;

namespace GitVersionSysDrawingIssue
{
    class Program
    {
        static void Main(string[] args)
        {
            var version = Assembly
                       .GetExecutingAssembly()
                       .GetCustomAttribute<AssemblyInformationalVersionAttribute>()?.InformationalVersion ?? "?";
            Console.Out.WriteLine($"--> Version {version}");
        }
    }
}
