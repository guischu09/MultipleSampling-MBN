
import os
import glob

# =============================================================================

def ListFolders(directory):
    ListAll = os.listdir(directory)
    ListFdPath = []
    FdNames = []
    for f in ListAll:
        FullPath = os.path.join(directory, f)
        if os.path.isdir(FullPath):
            ListFdPath.append(FullPath)
            FdNames.append(f)
    return(ListFdPath, FdNames)

# =============================================================================


def ListFiles(FolderPath, Filter='*'):
    return glob.glob(FolderPath + os.sep + Filter)

# =============================================================================

def ExistPath(path):
    return (os.path.isfile(path) or os.path.isdir(path))
# =============================================================================

def fileparts(fullfilepath):
    filename = fullfilepath.split(os.sep)[-1]
    fileDir = fullfilepath.split(filename)[0]
    return(fileDir, filename)

# =============================================================================

def LenArrayList(SomeList):

    LengthArray = []
    for array in SomeList:
        LengthArray.append(len(array))

    return LengthArray


# =============================================================================

def CompareList(elements):
    if len(elements) < 1:
        return True
    return len(elements) == elements.count(elements[0])