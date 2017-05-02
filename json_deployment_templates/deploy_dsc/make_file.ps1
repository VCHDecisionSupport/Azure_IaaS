Configuration MakeFile {
    Node "localhost" {
        File CreateFile {
            DestinationPath = 'C:\Test.txt'
            Ensure = "Present"
            Contents = 'Hello World!'
        }
        
    }
}