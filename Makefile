all:
	sudo bash -c setup.sh install

clean:
	bash setup.sh -c unlink
