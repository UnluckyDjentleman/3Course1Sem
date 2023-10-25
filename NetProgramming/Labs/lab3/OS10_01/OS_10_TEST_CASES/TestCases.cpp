#include"TestCases.h"

namespace TestCase {
	BOOL test1(HT::HTHANDLE* htHandle) {
		HT::Element* insertElement = new HT::Element("test1", 6, "test1", 6);
		HT::Insert(htHandle, insertElement);
		HT::Element* getElement = HT::Get(htHandle, new HT::Element("test1", 6));
		if (getElement==NULL||insertElement->keylength != getElement->keylength ||
			memcmp(insertElement->key, getElement->key, insertElement->keylength) != NULL ||
			insertElement->payloadlength != getElement->payloadlength ||
			memcmp(insertElement->payload, getElement->payload, insertElement->payloadlength) != NULL) {
			return false;
		}
		return true;
	}
	BOOL test2(HT::HTHANDLE* htHandle) {
		HT::Element* element = new HT::Element("test2", 6, "test2", 6);

		HT::Insert(htHandle, element);
		HT::Delete(htHandle, element);
		if (HT::Get(htHandle, element) != NULL)
			return false;

		return true;
	}
	BOOL test3(HT::HTHANDLE* htHandle) {
		HT::Element* element = new HT::Element("test3", 6, "test3", 6);

		HT::Insert(htHandle, element);
		if (HT::Insert(htHandle, element))
			return false;

		return true;
	}
	BOOL test4(HT::HTHANDLE* htHandle) {
		HT::Element* element = new HT::Element("test3", 6, "test3", 6);

		HT::Insert(htHandle, element);
		HT::Delete(htHandle, element);
		if (HT::Delete(htHandle, element))
			return false;

		return true;
	}
}