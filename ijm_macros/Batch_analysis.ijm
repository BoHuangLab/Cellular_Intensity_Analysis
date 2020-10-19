/* This script is to analyze images in batch
*/

dir = getDirectory("Choose a Directory to analyze");
count = 1;
listFiles(dir);


function listFiles(dir) {
   list = getFileList(dir);
   for (i=0; i<list.length; i++) {
      if (endsWith(list[i], "/"))
         listFiles(""+dir+list[i]);
      else
         print((count++) + ": " + dir + list[i]);
         open(list[i]);
         runMacro("Rolling_ball_single_channel_threshold.ijm");


   }
}
