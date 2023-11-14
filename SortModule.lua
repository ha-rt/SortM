--[[
_____/\\\\\\\\\\\_________/\\\\\_________/\\\\\\\\\______/\\\\\\\\\\\\\\\__/\\\\____________/\\\\_        
 ___/\\\/////////\\\_____/\\\///\\\_____/\\\///////\\\___\///////\\\/////__\/\\\\\\________/\\\\\\_       
  __\//\\\______\///____/\\\/__\///\\\__\/\\\_____\/\\\_________\/\\\_______\/\\\//\\\____/\\\//\\\_      
   ___\////\\\__________/\\\______\//\\\_\/\\\\\\\\\\\/__________\/\\\_______\/\\\\///\\\/\\\/_\/\\\_     
    ______\////\\\______\/\\\_______\/\\\_\/\\\//////\\\__________\/\\\_______\/\\\__\///\\\/___\/\\\_    
     _________\////\\\___\//\\\______/\\\__\/\\\____\//\\\_________\/\\\_______\/\\\____\///_____\/\\\_   
      __/\\\______\//\\\___\///\\\__/\\\____\/\\\_____\//\\\________\/\\\_______\/\\\_____________\/\\\_  
       _\///\\\\\\\\\\\/______\///\\\\\/_____\/\\\______\//\\\_______\/\\\_______\/\\\_____________\/\\\_ 
        ___\///////////__________\/////_______\///________\///________\///________\///______________\///__
        
        SortM (Sort Module)
		Created by undiscvrd (har.t)
		https://github.com/ha-rt/SortM

		Verson 1.0
		Last Edited 11/13/2023

		Please keep this header in place.		
]]

local SortM = {}

--// Algorithm Functions
local function quickSort(arr, low, high)
	low, high = low or 1, high or #arr
	if low < high then
		local pivot = arr[high]
		local i, j = low - 1, low
		while j <= high - 1 do
			if arr[j] <= pivot then
				i = i + 1
				arr[i], arr[j] = arr[j], arr[i]
			end
			j = j + 1
		end
		arr[i + 1], arr[high] = arr[high], arr[i + 1]
		quickSort(arr, low, i)
		quickSort(arr, i + 2, high)
	end
end

local function insertionSort(arr)
	local n = #arr

	for i = 2, n do
		local key = arr[i]
		local j = i - 1

		while j > 0 and arr[j] > key do
			arr[j + 1] = arr[j]
			j = j - 1
		end

		arr[j + 1] = key
	end
end

local function selectionSort(arr)
	local n = #arr

	for i = 1, n - 1 do
		local minIndex = i

		for j = i + 1, n do
			if arr[j] < arr[minIndex] then
				minIndex = j
			end
		end

		if minIndex ~= i then
			arr[i], arr[minIndex] = arr[minIndex], arr[i]
		end
	end
end

local function bubbleSort(arr)
	local n = #arr
	local swapped

	repeat
		swapped = false
		for i = 1, n - 1 do
			if arr[i] > arr[i + 1] then
				arr[i], arr[i + 1] = arr[i + 1], arr[i]
				swapped = true
			end
		end
	until not swapped
end

local function mergeSort(arr)
	local function merge(left, right)
		local result = {}
		local leftIndex, rightIndex = 1, 1

		while leftIndex <= #left and rightIndex <= #right do
			if left[leftIndex] < right[rightIndex] then
				table.insert(result, left[leftIndex])
				leftIndex = leftIndex + 1
			else
				table.insert(result, right[rightIndex])
				rightIndex = rightIndex + 1
			end
		end

		while leftIndex <= #left do
			table.insert(result, left[leftIndex])
			leftIndex = leftIndex + 1
		end

		while rightIndex <= #right do
			table.insert(result, right[rightIndex])
			rightIndex = rightIndex + 1
		end

		return result
	end

	local function divide(array)
		local n = #array
		if n <= 1 then
			return array
		end

		local mid = math.floor(n / 2)
		local left = {}
		local right = {}

		for i = 1, mid do
			table.insert(left, array[i])
		end

		for i = mid + 1, n do
			table.insert(right, array[i])
		end

		left = divide(left)
		right = divide(right)

		return merge(left, right)
	end

	return divide(arr)
end


local AlgorithmList = {
	["QuickSort"] = quickSort,
	["InsertionSort"] = insertionSort,
	["SelectionSort"] = selectionSort,
	["BubbleSort"] = bubbleSort,
	["MergeSort"] = mergeSort
}

--// Main Functions
local function verifyArray(array)
	if array == nil or type(array) ~= "table" then
		warn("SORTM EXCEPTION | Table expected, got " .. type(array))
		return false
	end

	for _, v in pairs(array) do
		if type(v) == "number" then continue end

		warn("SORTM EXCEPTION | Only tables containing all numbers are accepted with SORTM currently.")
		return false	
	end

	return true
end

local function verifyAlgorithm(Algorithm)
	for i, _ in pairs(AlgorithmList) do
		if i == Algorithm then
			return true
		end
	end

	warn("SORTM EXCEPTION | Expected a valid algorithm, got " .. tostring(Algorithm))
	return false
end

local function Sort(Array, Algorithm)
	if not verifyArray(Array) then
		return Array
	end

	if not verifyAlgorithm(Algorithm) then
		return Array
	end

	local sortFunction = AlgorithmList[Algorithm]
	sortFunction(Array)

	return Array
end

--// Defining Functions
SortM.VerifyArray = verifyArray
SortM.Sort = Sort
SortM.AlgorithmList = AlgorithmList

return SortM